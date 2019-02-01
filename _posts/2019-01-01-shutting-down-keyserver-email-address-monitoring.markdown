---
title: "Shutting down keyserver email address monitoring"
permalink: /shutting-down-keyserver-email-address-monitoring/
category: security
---

## Short version

[Ian](https://twitter.com/idrysdale) and I run two free services to help PGP users:


1.  **Expirybot** — sends emails 3 days before keys expire with simple instructions on how to extend the key.
1.  **Monitor** — realtime(ish) alerts when a new key is uploaded to the public keyservers with your email address.

Expirybot will continue and thrive!

Monitor is shutting down. We currently monitor thousands of email addresses, but for lots of reasons it's been difficult and stressful to run and maintain.

Ian and I are now working full time on Fluidkeys, [making PGP simple for engineering teams.](https://www.fluidkeys.com/fluidkeys-v1-preview/) If you'd like to keep up with our work on Fluidkeys please either sign up to release announcements at [https://www.fluidkeys.com](www.fluidkeys.com) or [give us occasional feedback on our Fluidkeys work.][fluidkeys-feedback-list]

Thanks!

Paul

<!--more-->

## Background: Monitoring the keyserver network for your email address

This was a side project I set up in 2018 based on feedback from people who had already received an expiry reminder from Expirybot.

The idea was simple: you sign up your email address, I verify it, then I regularly search my keyserver for your email address. I record the key fingerprints I see each time, and email you if a new one appears.


## Monitor was trickier to run than I anticipated

In the year I've been running Monitor, it's been quite tricky to keep running and I've had a number of outages. Some of these were my fault and others were issues with the keyserver network.

Outages in this service aren't the end of the world: you might get an alert a few days late, but I've hit increasingly awkward problems which prevent the service working reliably.

If you're curious, here's a rough idea of some of the problems I've encountered:


*   In June 2018 a [researcher found and accidentally unleashed a denial of service](https://bitbucket.org/skskeyserver/sks-keyserver/issues/60/denial-of-service-via-large-uid-packets) on a number of keyservers. For many (including mine) this caused gigabytes of DB transaction logs to quickly fill the disk and corrupt SKS' database.

*   After restoring SKS and improving its transaction log handling, the legacy of the malicious key lived on, causing my whole server to hang for around a minute several times an hour while trying and failing to reconcile with other servers.

*   These SKS hangs had a knock-on effect to my web app, causing it in turn to hang and return gateway timeout errors.

*   Several people who signed up have very short email addresses (fair!) which, when searched in SKS, would cause it to hang and timeout.

*   To try and support short email addresses, I switched from SKS to [Hockeypuck.](https://hockeypuck.github.io/) The documentation was lacking but I _did_ manage to get it syncing with the network (thanks [Fabian](https://lists.nongnu.org/archive/html/sks-devel/2018-08/msg00024.html)!) and working with short email addresses.

*   After a few months, Hockeypuck's postgresql database unfortunatelly filled the disk again, bringing down Monitor with it. It seems I should've regularly been running VACCUUM...

After that, I gave up, deleted Hockeypuck and disabled Monitor :(

It's weighed on my mind that Monitor doesn't run reliably and it's distracted me from Fluidkeys.


## Monitor with Fluidkeys?

If you're interested in monitoring your team's email addresses in the keyservers as part of a Fluidkeys subscription, we'd be delighted to help: email [hello@fluidkeys.com](mailto:hello@fluidkeys.com) and we'll work out how.

If you're just interested in what we're doing with Fluidkeys, sign up to our release announcements at [www.fluidkeys.com](www.fluidkeys.com). If you'd like to be more involved, we'd love if you could [give us occasional feedback.][fluidkeys-feedback-list]


## Expirybot will live on

Ian and I are going to continue to run and maintain Expirybot. It's simpler than Monitor and it seems to be having a positive impact for lots of people too.

I'll follow up soon with a post about some nice changes we're making there too.

## How I'll handle your data

If you signed up to monitor your email address, I'll delete your email addresses from the monitoring service by the end of February 2019. I'll also ensure email addresses are purged from log files and backups.

If you signed up to monitor your email address _and consented for me to contact you for feedback_, I will add your primary email address to a new Mailchimp list called "People willing to give feedback on Fluidkeys" which only Ian and I can access. I'll send you an email via that list to confirm.

If you signed up to monitor your email but _didn't_ consent for me to ask you for feedback, I'll simply delete all your monitored email addresses and you won't hear from me again after February.

It's _really_ helpful getting honest critique: if you want to help our mission to simplify strong encryption, [please let us occasionally ask you for feedback][fluidkeys-feedback-list].

Thanks,

Paul

[fluidkeys-feedback-list]: https://eepurl.com/gffcu9
[paul-twitter]: https://twitter.com/fawkesley
