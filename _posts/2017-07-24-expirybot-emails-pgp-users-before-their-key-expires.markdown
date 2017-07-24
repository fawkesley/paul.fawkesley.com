---
title: "Expirybot emails PGP users before their key expires"
permalink: /expirybot-emails-pgp-users-before-their-key-expires/
category: security, sideprojects, gpgforhumans
---

A month ago I started a side project to try and make the world a little easier for PGP users. This is how I started small.

It's easy to moan about PGP, and occasionally people declare it 'dead'. But many groups like the Internet Freedom community continue to depend on PGP to safely carry out their work.

After many years of using and thinking about PGP I decided to open my ears, listen out for problems and see if there was anything I could do.

## PGP keys expire and people don't realise

I spend a bit of time in online communities where people get support using PGP. Something that comes up consistently is key expiry.

When you generate a PGP key, your software normally sets an expiry date in the future. This is a good idea as it means that if you lose the private key, the public key won't linger forever. When the date approaches, you can simply extend the expiry and continue to use the key.

Depending what software you use, the default expiry might be several years away. People forget, their key expires and the first thing they know about it is when someone else tells them.

This worsens the overall PGP user experience for everyone: the other person probably got a cryptic message while trying to email you, and now you feel silly and worried that you've caused this inconvenience.

This has happened to me, and I assumed it might happen to others too.

## I quickly tested an idea

I had an idea that I could email people just before their key expired. Before building something serious, I wanted to know how many people this actually happens to and how they'd react to a random email from a stranger.

I run a PGP keyserver - part of the public network of interconnected servers - so in theory I've got all the published keys.

![Screenshot of a search result from my PGP keyserver](/img/pauls-pgp-keyserver.png)

I hacked up a script to pull every key from my keyserver, parse the expiry date, and output a list of people whose keys were in expiring in 3 days from now.

Then I used mail merge to send a personal email to 100 of those people, explaining the situation and how to extend the key.

Not being a natural hustler, I found this terrifying, sending out a hundred emails to people I don't know. What if they hate me?!

## It's a problem worth solving

Within a few minutes, I had a new Twitter follower. I followed back and got a hearty thanks for the reminder. An email reply arrived from a stranger with a short thank you message.

> Helpful is an Understatement :-) Thank You for the Helpful Reminder.

This seemed like a promising start so I gave myself permission to build something automatic. A month later, I'm running a niche but significant service: I've sent thousands of emails, had dozens of nice exchanges and gained a load of insight from real users.

It's been a lovely month!

Thoughts? [@paul_furley][paul-twitter] [paul@paulfurley.com][paul-email]

[paul-twitter]: https://twitter.com/paul_furley
[paul-email]: mailto:paul@paulfurley.com
