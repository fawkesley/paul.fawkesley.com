---
title: "Sabbatical, week&nbsp;3"
permalink: /2017-sabbatical-week-3/
category: sideprojects, sabbatical
image: virustotal-detection-results.png
---

*This week I've laid some good groundwork for Expirybot and had fun playing part-time security researcher.*

<!--more-->

![virustotal showing virus detected](/img/virustotal-detection-results.png){: .img-responsive }

Alright, I'm cheating a bit, week 2 is missing, but for some reason I've been struggling to write up that week. I'll try and retro-post it later, for completeness.

This week has _flown_ by but it's been interesting and productive, with most of the week spent on Expirybot and security research.


## Finished migrating my PGP keyserver to debian

I didn't really want to have to do this, but unfortunately sks version 1.1.6 isn't available on Ubuntu. Since I was stuck on 1.1.5 I got dropped from [the public pool][sks-pool], meaning my server no longer received requests directly from members of the public. That didn't directly break Expirybot, since I'm still receiving updates from my keyserver peers, but there's other types of PGP improvement research which _does_ depend in getting raw traffic.

I took the opportunity to move off Digital Ocean and get a new server inside the EU - with [Hetzner][hetzner-vps], at an incredibly affordable 7 ish EUR per month for a 2GB machine. I managed to rebuild sks 1.1.6 and migrate keyserver.paulfurley.com without breaking too much. Shortly after, I'm back in the pool and once again receiving ~1% of global PGP keyserver queries.


## PGP-signed Expirybot's outgoing emails

This was harder than I expected, but I got quite a bit of independent feedback that my [PGP expiry emails](https://www.paulfurley.com/expirybot) should be PGP-signed.

I spent the first part of the week building this, and a new web service for handling unsubscribes (necessary for signing the emails).

I'm now in a _much_ better place for building new parts of the service, which I also started to test on people - more below. I spent a few hours on Friday [writing up how I sign the emails](https://www.paulfurley.com/signing-automated-expirybot-emails-with-gpg/).


## Wrote a scraper for auction data, then went to the auction

This is a bit off-the wall, but I'm quite interested that there are [houses for sale in Liverpool for less than £50K](http://www.suttonkersh.co.uk/properties/listview/?FormSearchText=&FormSearchTextField=&geolat=&geolon=&georad=&section=sale&transType=1&searchSales=Search&priceMin=0&propType=&priceMax=75000&beds=&location=), and some of them are in areas that I believe have an excellent future.

I've never been to an auction, and it wouldn't be right to go unprepared, so I built [a scraper to analyse the listings](https://github.com/paulfurley/sutton-kersh-property-auction-scraper/tree/master) before I went.

The auction was pretty exciting for two or three lots, then it got boring and I went home.

Nope, I'm not going to become a landlord just yet, but I am thinking about how to do it in a way that's not morally bankrupt, doesn't push up prices, and doesn't make it harder for people to buy houses.

I had a good email exchange with the nice folks from [Generation Rent](http://www.generationrent.org/) asking for guidance on what they consider being an ethical landlord. I'd much prefer to _build_ houses as an investment… now there's a worthwhile enterprise … but that's completely out of reach for me. For now I'm more interested in [investing in green energy.][abundance-investment]


## Investigated EE apparently leaking my phone number to a website

I had a fascinating, spooky experience on the internet that made me realise how internet security must feel for… lots of people.

_Somehow, _it looks like I clicked on a link on a website, and this alone **subscribed me to a premium rate SMS service**. I'm pretty outraged that this can happen, mostly because I'm concerned it means my phone number was transmitted to some Azerbaijan (literally) company's website without my consent.

I've got some very intelligent input from some contacts (thank you folks!) and I'm planning a full write up on this, but for now, here's the work in progress:


*   Me asking on [security.stackexchange.com](https://security.stackexchange.com/questions/175486/how-did-my-phone-provider-leak-my-msisdn-to-an-advertising-website) (no answers yet)
*   Me asking on [community.ee.co.uk](https://community.ee.co.uk/t5/4G-and-mobile-data/Why-do-you-leak-my-phone-number-to-websites-when-browsing-on/m-p/650170/highlight/false#M119468) (seems to be getting some traction now)
*   Interesting paper: '[Privacy Leaks in Mobile Phone Internet Access'](https://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf)
*   Another: '[Header Enrichment or ISP Enrichment? Emerging Privacy Threats in Mobile Networks'](http://www.icir.org/vern/papers/header-enrichment-hotmiddle15.pdf)

## Reported a probable security breach at the Gym Group

I've enjoyed playing part time security researcher this week!

I use unique email addresses for everything in order that I can figure out who spams me, and block that email address. I've got between 5 and 10 addresses now which have been compromised so I bounce them, much to my satisfaction.

This week I received an email to the unique address I used to use for the Gym Group, which I left years ago. It was a classic malware email, a friendly note asking for the status of the attached invoice:

![Screenshot of an email containing a dangerous attachment](/img/screenshot-of-malicious-email.png){: .img-responsive }


And, of course, it's [carrying some virus (virustotal.com).](https://www.virustotal.com/#/file/d40a85793b528e171de6753a5f87ec6a86ab924c89dce33b69d43de4c47559ab/detection)

I reported this to the Gym Group - slowly - and pointed out it's a pretty good sign they've breached their customer database. I wonder if they'll investigate and [report this to the Information Commissioner's Office](https://ico.org.uk/for-organisations/guide-to-pecr/communications-networks-and-services/security-breaches/)?

If you're reading this, Gym Group, top tip: take security disclosures seriously - you didn't make it easy!


## Asked for feedback on new Expirybot features

Over the last 6 months, as Expirybot has been sending people helpful reminders about their PGP key, some people have generously been filling out a little survey, helping me understand what they use PGP for and so on.

That data in itself has been really helpful, and in addition many of those people agreed to be contacted again.

I've been thinking of new things my Expirybot project could do, but unlike the current reminders, which are unsolicited, I wanted to get upfront permission to do more.

I emailed 50 of my respondents explaining that I'm working on six features, and would they like to sign up and give me feedback. To my delight, a few people have already replied saying yes, and I've got some good, granular feedback on which features people are interested in. Awesome!

Here's the list - if you've got any feedback, let me know!

*   Email people earlier - like 30, 14, 7 days
*   Notify people when a potentially suspicious new key is added with your email address
*   Provide ICAL calendar feeds for keys
*   Notify people their key's cipher preferences (eg SHA1) are no longer considered secure
*   Inform people their (unsafe) short ID is being queried in the keyservers, and helping them correct it
*   A command-line tool (GPG wrapper) to generate, rotate / extend your primary key and subkeys automatically
*   A teams tool for monitoring all the keys for an organisation e.g. @yourdomain.com


[Thoughts? Get in touch.][paul-twitter]

[paul-twitter]: https://twitter.com/paul_furley
[sks-pool]: https://sks-keyservers.net/status/
[abundance-investment]: https://www.abundanceinvestment.com/
[hetzner-vps]: https://www.hetzner.com/virtual-server?country=gb
