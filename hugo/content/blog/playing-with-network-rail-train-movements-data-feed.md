---
date: "2016-02-22"
title: Playing with Network Rail Train Movements Data Feed
permalink: /playing-with-network-rail-train-movements-data-feed/
category: sideprojects
---

*On Friday I played with the Network Rail [Train Movements][train-movements-documentation]
data feed. This contains signalling messages from across the UK rail network.
I've started working on a more developer-friendly Python API.*

## About the Train Movements Data Feed

I've been interested in the [Train Movements][train-movements-documentation]
data feed for a while as it gives near real-time access to train locations
across the network. There are many points on the network that can report
location - not just stations - so there's a reasonable volume of updates.

The particularly neat thing is that this data feed categorises movements
as things like "arrival" and "departure" and compares the timestamp with the
expected (timetabled) timestamp. I've got a few ideas up my sleeve about what
this data could be used for, so I spent some time playing with the data.

## Accessing Network Rail Data Feeds

You need to [request a developer account][request-developer-account] in order
to get access to the Network Rail data feeds. For some reason they limit these
accounts to only 500 developers. After reactivating my account from several
years ago, I fired up some old code I'd written to get started and was pleased
to find it still worked.

## Making Sense of Train Movements

There are several types of message given by the Train Movements data feed which
allow you to build up the state of all trains on the network according to [this
state machine][state-machine]. However, for now, I'm just interested in message
type 3: "Train Movement". These are the instantaneous location reports from a
particular location, and they look like
this:

```json
{
    "body": {
        "variation_status": "LATE",
        "planned_timestamp": "1455883470000",
        "event_type": "DEPARTURE",
        "train_terminated": "false",
        "direction_ind": "UP",
        "toc_id": "88",
        "auto_expected": "true",
        "event_source": "AUTOMATIC",
        "reporting_stanox": "87701",
        "gbtt_timestamp": "1455883440000",
        "platform": " 1",
        "correction_ind": "false",
        "original_loc_stanox": "",
        "planned_event_type": "DEPARTURE",
        "timetable_variation": "2",
        "delay_monitoring_point": "true",
        "line_ind": "F",
        "next_report_stanox": "87700",
        "train_id": "892A39MI19",
        "offroute_ind": "false",
        "current_train_id": "",
        "loc_stanox": "87701",
        "next_report_run_time": "1",
        "route": "2",
        "train_file_address": null,
        "division_code": "88",
        "actual_timestamp": "1455883560000",
        "original_loc_timestamp": "",
        "train_service_code": "24745000"
    },
    "header": {
        "user_id": "",
        "msg_type": "0003",
        "msg_queue_timestamp": "1455883630000",
        "source_dev_id": "",
        "original_data_source": "SMART",
        "source_system_id": "TRUST"
    }
}
```

First impressions are that there are a lot of magic numbers, for example
`"reporting_stanox": "87701"`. I'm sure rail professionals know what this means
but it's completely baffling to me, a mere developer.

The [documentation][train-movements-documentation] is *OK* but could do with
improving. *(I did try to sign up for the Wiki in order to help out, but when
asked for a 50 word
"bio" I got snarky and they understandably probably hit delete!)*

Alas, the documentation isn't hosted on Github so I can't just submit issues &
pull requests: I have to ask for permission to be able to even comment.

## Making Sense of Train Movement Messages

There are lots of magic IDs in this data so I set about trying to decode some
of them. To keep it simple, I decided to decode:

- The Train Operating Company (`toc_id` and `division_code`, apparently)
- The arrival or departure station.

### Train Operating Company

This bit was simple enough - it turns out that `"toc_id": "88"` is called a
"Numeric Code" and there's a [table of them here][operating-companies-table].
Curiously there are a further two "unique" identifiers used to refer to these
companies, but I'm not too worried about those at the moment.

I spent some tedious minutes turning the HTML table into a
[JSON file][operating-companies-json] to help my future self and others.

### Arrival & Departure Station

This one was a bit trickier. There's a thing called a STANOX (which I've seen
unshortened as a Station Number) which appears to refer to locations as well as
other places like Engineering buildings.

In order to map STANOX to locations, there's something called the
"Reference Data" (also requiring a developer account). That leads to a 6.5MB
JSON file called `CORPUSExtract.json` containing records that look like this:

```json
{
    "TIPLOC": "LVRPLSH",
    "UIC": "22460",
    "NLCDESC16": " ",
    "STANOX": "36151",
    "NLC": "224600",
    "3ALPHA": "LIV",
    "NLCDESC": "LIVERPOOL LIME STREET"
},
```

Note the `3ALPHA` field - that's the station code you often see on booking
websites. It also goes by another two or more names, but let's not talk about
that.

Many of the entries in the reference data have a STANOX but not a 3ALPHA field,
and vice versa. Either way, now we've got the mapping we need.

I couldn't find any information about how often the reference data is updated,
and I didn't explore whether the webserver reports an etag or last-modified. At
the moment it's not clear how you're supposed to automate keeping the reference
data up to date.

*I don't know what licence this reference data is but I'll try and clarify that
and if possible I'll check it into Github.*

### Putting it all together

That was a quick whizz through. I wrote some Python to decode these messages
and put it on [Github][github-repo] (although at the time of writing it's in a
branch). This is the output after decoding (and re-serializing as JSON):

```json
{
    "planned_event_type": "departure",
    "status": "on_time",
    "planned_datetime": "2016-02-22T08:48:00",
    "actual_datetime": "2016-02-22T08:48:00",
    "planned_timetable_datetime": "2016-02-22T08:48:00",
    "early_late_description": "on time",
    "location": {
        "name": "EBBSFLEET INTERNATIONAL",
        "stanox_code": "89530",
        "three_alpha": "EBD"
    },
    "location_stanox": "89530",
    "operating_company": {
        "name": "Southeastern",
        "business_code": "HU",
        "numeric_code": 80,
        "atoc_code": "SE"
    },
    "is_correction": false
}

```

At the very least this makes the station and train operating company a little
more understandable.

## What's Next

First I'd like to spend some time releasing the code I've built as an actual
Python library so that more code can be built on top of it, without coupling
to its implementation. Then I've got some real projects I'd like to try out,
but more on those in the future.

*Interested? Do get in touch, my email is paul at this domain.*

[train-movements-documentation]: http://nrodwiki.rockshore.net/index.php/Train_Movements
[request-developer-account]: https://datafeeds.networkrail.co.uk/
[state-machine]: http://nrodwiki.rockshore.net/index.php/TRUST_Message_Process
[operating-companies-table]: http://nrodwiki.rockshore.net/index.php/TOC_Codes
[operating-companies-json]: https://github.com/paulfurley/network-rail-data-feeds-python/blob/master/db/operating_companies.json
[github-repo]: https://github.com/paulfurley/network-rail-data-feeds-python
