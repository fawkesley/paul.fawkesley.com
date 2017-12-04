---
title: "Sabbatical, week 1"
permalink: /2017-sabbatical-week-1/
category: sabbatical
image: sefton-park-palm-house.jpg
---

This time last week I wrote about experiencing [Writer's Block](https://www.paulfurley.com/writers-block/), and how I was struggling to face the idea of making anything. I'd given myself what I think was an unhealthy goal of doing four product launches in four weeks. But launching products is mostly hard hustling, and what I love is building and automating things.

<!--more-->

My first week of sabbatical has been lovely and a little surprising. I've spent time automating some little things I've been meaning to do which I've found really satisfying (even if [Zarino](https://www.zarino.co.uk/) says this is equivalent to tidying my room!)

I've done quite a bit of meditating too, and thought about what I'm trying to achieve and how I'm going to fit it into my life.

And I've spent some nice time with friends and family, and their guidance has been helpful as always.

## Received refurbished air quality eggs

It's been a while, but at last, we ([Engage Liverpool CIC](https://www.engageliverpool.com/)) have got five working Air Quality Eggs. These arrived this week and I unpacked them and got them talking to the internet.

They can measure NO2 and CO and they work over WiFi, so they need to be positioned somewhere. We're looking for ideas where to put them and what we could do with the data they're producing.

![An air quality egg with an illuminated display](/img/air-quality-egg.jpg){: .img-responsive }

## Added a 'buy me a beer' page for Expirybot

[Expirybot](https://www.paulfurley.com/expirybot-emails-pgp-users-before-their-key-expires/) is a lovely little project I've been running since July. I get quite a few thank-yous by email and Twitter, and this week someone asked how they can buy me a beer.

I've been wondering - skeptically - whether I should make some sort of 'donate' page, since Expirybot costs some money to run, and it'd be more resilient if its users could pay for it rather than me.

It seemed like no harm in adding a buy-me-a-beer page and linking to it from Expirybot's pages.

To my absolute delight, a few hours after deploying the page, I received two 'beers' via Paypal from happy users of Expirybot. Result! I'm really grateful to those people.


## Added Open Graph tags to my website

Previously, when a Tweet or Facebook share or whatever linked to my website, the tweet looked really boring:

![Screenshot of a tweet with a URL](/img/tweet-without-open-graph-tags.png){: .img-responsive }

So I [added HTML Open Graph tags](https://github.com/paulfurley/www.paulfurley.com/compare/82620fc90bbd15140e9a8ac95a801915e08594c2...58c7fde62c74fe00b1d1b09a9f30641138f6575e) which gives a hint to other services how to display the link nicely:

![Screenshot of a tweet with a URL, enhanced with an image and a bold headline](/img/tweet-with-open-graph-tags.png){: .img-responsive }

## Randomise MAC addresses

I built a script to randomize my MAC address so that it's unique across different WiFi networks, and rotates every 24 hours. More about that below...

## Automated logging into the library's captive portal

Having randomized my MAC address, I was faced again with Liverpool library's crappy [WiFi SPARK](https://www.wifispark.com) login screen.

As the [EFF eloquently explain](https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy), this type of craptive portal is harmful to user security as well as being a pointless waste of (everyone's) time.

Since the 'sign in' step doesn't actually *do* anything I thought I'd get my own back by automating it.

Now I just type `craptive_liverpool_library` and two seconds later, I'm in!

## Wrote about how PGP keyservers work

I often get into interesting email conversations with people as a result of Expirybot, and this week I helped someone understand a bit about how the PGP keyservers work. This should probably be a whole blog post, but since I wrote it already, I'll reproduce it here for now.

If you're interested, this is roughly how it works...

There's some open source software called [SKS](https://bitbucket.org/skskeyserver/sks-keyserver/wiki/Home) which implements a
protocol called 'HKP' which describes a keyserver. The 2 functions of the software are:

1. responding to queries from users (search, get, upload)
2. synchronising with peers (other keyservers)

The keyservers are run by different types of organisations - universities, companies and individuals. When you start a new keyserver,
you email the [sks-devel mailing list](http://nongnu.13855.n7.nabble.com/SKS-Devel-f83255.html), asking for people to peer with you. That means your server will 2-way synchronise with that peer.

So if you push a key to [my keyserver](https://keyserver.paulfurley.com), within a few minutes all of the other ones in the network will have it too.

`sks-keyservers.net` is a clever domain that randomly resolves to any one of the 'pool' of keyservers currently considered 'acceptable' for public use - you can see the list here:
[https://sks-keyservers.net/status/](https://sks-keyservers.net/status/)

(Mine recently got dropped from the pool until I upgrade my SKS to the latest version!!)

There are other domains like keys.gnupg.net which the GPG team control, too.

Now, this may seem a bit chaotic, and in some ways it is.

**BUT** the massive advantage, as I'm sure you're aware, is that no one organisation controls it, no-one can kill it. No-one can decide to sell it for profit, or shut it down because it's too difficult to run.

The beauty of the 'bunch of nerds running it in their bedrooms' (probably there's at least one) is that **everyone** would have to collude in order to break it.

On that exact topic, in the future I think we'll look back at SMTP as one of
the most important inventions we've ever come up with... Just think how
impressive it is to make ***a single global standard*** for communication, with
no company or government in control!! I'd happily bet on email outliving
Facebook ***any*** day ...


## Meditated at the Palm House

I've been going to meditation classes for the last couple of months. They've recently started running a Wednesday morning class in the beautiful [Sefton Park Palm House.](http://palmhouse.org.uk/)

I went along and… wow… what a wonderful place to meditate. The tropical plants in the palm house give it an incredible smell and it was all warm and cozy compared to the crisp, frosty weather outside.

![A glass palm house visible through trees](/img/sefton-park-palm-house.jpg){: .img-responsive }

Afterwards, I spent a serene hour walking round the park in the cold sunshine talking to my mum on the phone.

The next few hours flew by as I dropped in to the [Kadampa Meditation Centre](http://meditationinliverpool.org.uk/the-centre/) and chatted away to two of the residents there. They're part of a community of fifteen that co-habit in a superb Victorian building that was previously the private mansion of a Liverpool ship owner.

This morning reminded me how easy it is to prioritise the wrong things. Often I'm 'too busy' to prioritise time with family or it feels 'unproductive'. I've made the mistake of thinking that time not in front of the computer is somehow 'wasted'.

Well, I do love building things, but it mustn't come at the cost of ignoring the things that really matter.


## Did a day course at the Meditation Centre

On Saturday I returned to the meditation centre for a day course on [mindfulness and concentration](http://meditationinliverpool.org.uk/event/mindfulness-concentration/).

The format of the day was four sessions, with teaching in each session and one or more simple breathing meditations in each session. The time between sessions was fun too, meeting others who've been meditating for decades, and enjoying hanging out at the centre.

I've got more to write on my experience of meditation so far. The teaser is that I've been meditating in various forms for a while, but without really understanding why. I've been doing it because it feels good, but there's been no bigger goal. Now I've started to see the bigger picture, I'm pretty hooked...


## Returned to Gladstone library

On Sunday, [Francis](https://www.flourish.org/) and I did a day trip to Gladstone's library, where I'd been on retreat last weekend. I've joined as a friend which gives access to the library every day from 9 till 10pm, and I think it's going to be a useful place for thinking and working.

It's calm and civilised, and Hawarden's got some nice countryside and decent pubs.

It was nice - and helpful - doing an 'away day' with Francis, who understands me well. As he sensibly points out, Expirybot would be a good thing to spend my sabbatical on - I love working on it, I understand the area well (PGP, encryption, etc) and it's already got hundreds of happy users.

Why fret about building something new, for a new group of people, when I've got a huge backlog of features and ideas for improving Expirybot?


## Wrote up blog post about randomizing MAC addresses

On Friday I had spent a bit of time working out how to randomize my computer's MAC address without breaking things. On Sunday I decided to [write it up and explain why I did it](https://www.paulfurley.com/randomize-your-wifi-mac-address-on-ubuntu-1604-xenial/) so that others could benefit.

Excitingly, it hit the [front page of Hackernews](https://news.ycombinator.com/item?id=15837273) so it ended up taking most of my Sunday at Gladstone's, responding to comments and tweets and tweaking the blog post based on feedback.

It was fun writing up _why_ I'm interested in that and explaining how MAC address tracking works.

For the analytics geeks: hovering around Hackernews in position 8-9 from about midday to midnight on a Sunday UK time equated to about 6,500 page views according to Google Analytics. That's a big spike against my base of about 300 page views per week. But if you were banking your startup on a 'big reveal' launch, you'd have to better than just front-paging HackerNews.


## Started automating my email with Inboxbot

My email inbox is full of useless old crap that could have been deleted weeks ago.

I'm quite good at using Fastmail's filters to organise things into folders, but everything that doesn't fit into a folder tends to stack up indefinitely.

To be honest, this probably already exists, but I was curious to build something that talks over IMAP. I also want to be able to source control my rules, rather than them being in Fastmail's web GUI.

It's also nice to be able to delete certain types of mail some-number-of-days after they arrived. For example, Meetup seems particularly noisy, with emails like "Tomorrow: Joins us blah blah"

Now I can delete those emails after a couple of days:

```
rules:
  - search:
      folder: "Inbox#"
      from: "info@meetup.com"
      subject: "Tomorrow: Join us"
      older_than_days: 2
    action: "delete"
```

Another bit of hygiene I'd like to instigate: Sometimes I'll buy something from a company, I'll definitely not opt-in to marketing, then several months later I mysteriously start getting their sales emails.

I'm going to try a rule that automatically unsubscribes from anything that didn't make it into my 'newsletters' folder… ha! This is possible with the 'List-Unsubscribe' header.

This might be yak-shaving, it might be worthwhile. I'm enjoying it, and it's my sabbatical, so there!



[Thoughts? Get in touch.][paul-twitter]

[paul-twitter]: https://twitter.com/paul_furley
