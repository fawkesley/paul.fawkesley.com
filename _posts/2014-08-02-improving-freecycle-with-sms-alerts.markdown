---
title: Improving Freecycle with SMS Alerts
permalink: /improving-freecycle-with-sms-alerts/
category: sideprojects
---
I love the concept of Freecycle - you've got something you want to get rid of, so you offer it for free on the condition that someone comes and collects it. It's still basically a simple email list where you write OFFER or WANTED in the subject - nothing too fancy.

Historically I've mostly donated on Freecycle as I've found it to be a great way of de-cluttering - getting someone to turn up and collect your stuff is awesome. Sometimes you meet really lovely people too and there's a feel-good factor.

## Signal to Noise

*Receiving* on freecycle, however, isn't as smooth as donating. At the moment I'm looking for something quite specific - a king-sized bed - and I'm experiencing a couple of problems with this use-case:

  * If you receive all offers as individual emails then you get swamped with unrelated emails- too much *noise*!
  * But choose message digest and by the time you see an offer, someone else has already got it!

If you're busy and it's not practical for you to read every single email as they come in, you're at a disadvantage when it comes to receiving on Freecycle.

![screenshot of lots of emails from freecycle](/img/freecycle-too-many-emails.png){: .img-responsive }

As I see it, there are two distinct problems for my use case:

  1. **Inadequate filtering** - 99% of items aren't relevant to someone looking for a specific item, so it's crazy for them to have to read each one.
  2. **Time sensitivity** - unfortunately donors often just say yes to the first person who asks, so you have to get in quick.

The result of these two problems - and I've heard this grumbled about by moderators - is that Freecycle tends to advantage the dreaded "traders" (eBay sellers) who have got time to sift through emails and respond very quickly.

Personally I don't care where my stuff goes - if someone wants to make some money where I couldn't be arsed, good for them. But it does mean that it can be difficult to actually find something when you're looking for it.

## A Very Simple Solution

This afternoon I hacked up an incredibly simple system using a couple of new services I had been meaning to try out. The basic premise is simple - I choose some keywords, and any matching offers cause an SMS to be sent to my mobile. This way I can ignore anything unrelated, and react quickly whenever I receive an SMS.

Here's how it works.

  1. Freecycle OFFER emails all go to a unique <a title="cloudmailin" href="http://cloudmailin.com" target="_blank">cloudmailin.com</a> address.
  2. CloudMailin encodes the email as JSON and sends an HTTP POST to <a title="Freecycle SMS alerts" href="https://github.com/paulfurley/liverpool-freecycle-alerts" target="_blank">my Flask app</a> running on Heroku.
  3. My app checks the email subject and body for the given keywords.
  4. If the email matches a keyword, the app uses <a title="Twilio" href="https://www.twilio.com/" target="_blank">Twilio</a> to send an SMS to my mobile.

Here are emails coming in to CloudMailin - you can see where I did a lot of messing around breaking my web app.

![CloudMailIn email management panel](/img/cloudmailin-email-management-panel.png){: .img-responsive }


It's massively minimalist but it does work nicely and there are unit tests, obviously, so it's not a total hack! Currently all settings are read straight from the environment so it only works for a single user. But still, it does work and it proves the concept.

![SMS alert received from a Freecycle email](/img/freecycle-sms-alert.png){: .img-responsive }
*Freecycle SMS Alert*

I've been been really impressed how easy it was to get up and running with two new services - CloudMailin and Twilio. It's great to have such powerful building blocks which can be easily rigged together to create very powerful solutions.

Is this something you'd be interested in? Visit the [repo on GitHub](https://github.com/paulfurley/liverpool-freecycle-alerts) and do get in touch and let me know.
