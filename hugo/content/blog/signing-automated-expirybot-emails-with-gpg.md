---
date: "2017-12-15"
title: "Signing automated Expirybot emails with GPG"
permalink: /signing-automated-expirybot-emails-with-gpg/
category: security, sideprojects, python, devops
image: /signed-email-from-expirybot.png
---

*I've started PGP-signing Expirybot's outgoing emails, but in the process had to build a web service to handle unsubscribes, bounces, complaints and invalid domains.*

<!--more-->

![Expirybot email signed with GPG](/img/signed-email-from-expirybot.png)

I get a lot of emails back from people who've received [my PGP expiry notification emails](https://www.paulfurley.com/expirybot). One of the requests that's come up several times is,

'This is PGP, why don't you encrypt and sign the emails'?

## Many people have lost their PGP keys

Encrypting the emails is problematic: given that these are expiry emails, many people I email have lost access to their key, so they wouldn't be able to decrypt the message. Some people don't have a clue what PGP is (either their email address was re-used or they forgot). These people tend to be suspicious of the email, although a few people reply and ask what it's all about, after Googling me. If the emails were encrypted, I'm not sure how those people would react to a scary-sounding subject and an unreadable message body. I decided encrypting expiry emails is probably unwise.

But I should _definitely_ sign the emails. The reason I haven't been is that I've been using Mailgun to send my emails. They offer a very helpful feature where they can automatically add an unsubscribe link to your outgoing emails. This saved me a load of time, since I could just go ahead and send emails and let them handle unsubscribes and suppress any future emails sent to an unsubscribed user.


## Signing emails breaks Mailgun's unsubscribe links

The problem is, if I sign the emails, it's difficult for Mailgun to add to my email without it either breaking the signature or it sitting _outside_ the closing `-----END PGP SIGNATURE-----`. Neither is ideal

Long story short: I did a lot of legwork to implement my own unsubscribe functionality, and now I'm sending GPG-signed emails.

As you can see I'm using _inline_ signatures - where the message body is the signed text - rather than the [PGP/MIME][pgp-mime] format. The reason is that PGP/MIME signed emails appear with an attachment called `signature.asc`. That's fine for people who understand PGP, but as I described above, the more suspicious users probably won't take well to an unfamiliar email attachment.


## Automating unattended GPG is quite interesting

I created a [new PGP key][expirybot-pgp-key] for Expirybot and I needed to be able to access it from my Python code. That meant there wasn't a lot of point having a password on the key.

Equally, I wanted to limit the damage of putting a private key sitting on a server, waiting to be stolen someday.

I used the same trick I do on my own key, where I exported the signing _subkey_ - without a password - and let Expirybot use that. The _primary_ key I store safely elsewhere, and in a year I can use it to extend the subkey's expiration and upload it again.

Knowing that I'd forget how I did it, I scripted the key generation and export. You might find it useful for your own keys - [it's on Github, of course](https://github.com/fawkesley/expirybot/blob/master/expirybot/gpg_wrapper/generate_keypair). (Please don't judge me by Expirybot's less-than-perfect code which I admit has a lot of technical debt!)


## I built a new web service for blacklisting

I made the decision to move away from Mailgun's unsubscribe functionality and build my own. I'd been resisting this a bit because in order to provide links people can click on, I need to run a new, always-on, internet-facing (simple) web service. I do love running services like this, but until now Expirybot has been a best-effort bunch of shell scripts and Python strung together in cron. If something's failed it really hasn't mattered since maybe someone wouldn't get a reminder email, but so what?

Building a proper web service is actually a great opportunity to do more of the ideas I've got for Expirybot which justified spending the time to get it built and deployed.


### User-facing unsubscribe endpoint

This is the obvious bit: the link that a user clicks on. I used [JSON web tokens (JWT)][json-web-token] to create signed links to add some protection against people changing each other's subscriptions.

Here's an example of an unsubscribe link:

```
/unsubscribe/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjExMjQxMDAsImVtbCI6Im5vYm9keUBleGFtcGxlLmNvbSJ9.4QHDqjoyAhV6V2cBlRO2EuWAYwSv-4RvbrPxwOBbKhE/
```

If you [decode the JWT][decode-jwt] you'll find it contains this payload:

```json
{
  "exp": 1521124100,
  "eml": "nobody@example.com"
}
```

### List-Unsubscribe email header

I wanted to allow mail clients like Gmail and Apple Mail to show those 'magic' unsubscribe buttons - making it easier for people to unsubscribe, rather than hitting spam. This is enabled by using the `List-Unsubscribe` header in the outgoing emails.

There are two forms of `List-Unsubscribe`: URL and `mailto:` links. In the `mailto` version, when the user hits the button, the mail client actually sends an email to the address. This is instant, so it's preferable to being sent to a website. It's also safer, since a website could deliver adverts or malware.

For now, I've only done the URL link, but I'd like to implement the `mailto:` version soon too.


### 'Get unsubscribe link' API endpoint

In order for Expirybot (which is still cron + shell script + Python) to insert unsubscribe links into emails, it needs to be able to generate the link.

I made a protected API endpoint which Expirybot can call and ask for a link. This endpoint serves a dual-purpose: it _also_ checks that email address and domain against the blacklist. It only returns an unsubscribe link if they're _not_ unsubscribed, so Expirybot can't accidentally email someone that it shouldn't be.

The unsubscribe link contains a JSON web token, signed with Django's `SECRET_KEY`.

## Synchronising with Mailgun

Of course, I needed to import the existing unsubscribe list from Mailgun so I couldn't email those people who'd previously unsubscribed.

In addition, there were three more things I wanted to import and continue to synchronise with my own service:

1. **Bounced email addresses**- there were thousands of these, since many PGP keys are very old.
2. **Complaints** - there were about 20 of these - these are when someone hits 'report spam', and their email provider supports a 'feedback loop' which sends the report back to Mailgun.
3. **'No MX' domains** - Mailgun tries for several days to connect to a domain to deliver email, but ultimately it gives up and logs an error. I didn't want to continue to email these domains, since they're either invalid, or they've probably changed ownership.

I wrote some Python scripts to synchronise these with my own blacklist, and got it running in cron. This is lovely since I now have a 'single customer view' (as they call it in big corporations). That is, I can see everything that's happened for a given email address, and with that I can get a feel for when I'm helping or annoying people.


## Next up for Expirybot

At the moment the 3-days-until-your-key-expires emails I send are unsolicited.

So far, that seems OK - the ratio of happy users to unsubscribes or complaints is very high.

However, I want to do more with Expirybot, like:

*   Email people earlier - like 30, 14, 7 days
*   Notify people when a new key is added with the same email address as an existing key
*   Provide ICAL calendar feeds for keys
*   Notify people their key's cipher preferences (eg SHA1) are no longer considered secure
*   Inform people their (unsafe) short ID is being queried in the keyservers, and helping them correct it

To do this, I feel I need to get their opt-in. The next thing I'm doing for Expirybot is a way for people to 'sign up' to monitor they key or email address.

This will be completely free. If it's something you're interested in, [pop me an email][paul-email] and I'll sign you up next week when it's built. And of course, you'll be able to use my new unsubscribe functionality if you change your mind :)




[pgp-mime]: https://tools.ietf.org/html/rfc3156
[expirybot-pgp-key]: https://keyserver.paulfurley.com/pks/lookup?op=vindex&search=0x9DE7A89E2DE2536F
[example-unsubscribe-link]: https://www.expirybot.com/unsubscribe/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjExMjQxMDAsImVtbCI6Im5vYm9keUBleGFtcGxlLmNvbSJ9.4QHDqjoyAhV6V2cBlRO2EuWAYwSv-4RvbrPxwOBbKhE/
[json-web-token]: https://en.wikipedia.org/wiki/JSON_Web_Token
[decode-jwt]: https://jwt.io/
[paul-twitter]: https://twitter.com/fawkesley
[paul-email]: mailto:paul@paulfurley.com
