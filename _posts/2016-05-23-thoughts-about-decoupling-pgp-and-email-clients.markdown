---
title: Thoughts about decoupling PGP and email clients
permalink: /thoughts-about-decoupling-pgp-and-email-clients/
image: resisting-the-urge-to-build-thumbnail.jpg
category: security
---

Thanks to the Bitmask session at the Internet Freedom Festival 2016 for starting me off thinking about this. 

I want to see widespread adoption of end-to-end email encryption. Email is brilliant, it's not going away, and it's fast becoming the least-secure part of our Internet lives.

Why can't I opt in to PGP-encrypted bank statements by email? Why can't I exchange encrypted emails with my mum?

This post is some ideas about getting **non-geek users** using PGP. To keep things simple let's imagine an Apple user who currently uses Apple's mail clients on the desktop and phone.

I believe if we want to gain mass adoption of end-to-end email encryption, we need to do two things:

1. Hide encryption from the user.
2. Stop trying to build PGP into mail clients.

## Hide it from the user

The first point has become obvious thanks to services like iMessage and WhatsApp which just went ahead and built end-to-end crypto and barely told anyone about it. They *hid the crypto bits* rather than making the user understand them. They had the advantage of using a *centralized* public-key infrastructure, so we have to trust them not to screw us over.

On the second point, ordinary users are not interested in learning about public/private key pairs or verifying key fingerprints. Let's not make them.

One of the objections I hear about hiding crypto goes along the lines of "then it's easy to man-in-the-middle those users, so there's no point doing it".

Yep, if we automate and hide the hard stuff, those users will have a less secure PGP experience than us geeks, but *it's a lot more secure than what they're currently doing!*.

Let's stop aiming for perfect. Today everything is broken. Tomorrow, let's aim for slightly less broken.

## Stop trying to build PGP into mail clients

Apple make beautiful mail clients that people like to use. Their mail clients don't support PGP. Should I really be telling my friends and family to switch to Thunderbird and install this weird plugin called Enigmail?

And what's the story for mobile? Go and download *another* unfamiliar application, then get the app that syncs your keys, uhhh...

There are always going to be beautiful mail clients that don't care to support PGP. The skills required to make a beautiful mail clients are quite different from those required to implement PGP.

Mailpile is a valiant effort to do both - hooray to those folks - but I've come to believe that's the wrong approach.

I think we need to de-couple the mail client and the PGP capability.

## Personal PGP Proxies

How about this: every company, family or close organisation gets their own "PGP proxy". This is a small, publicly routable computer which performs several functions:

- Hold the public & private keys of users (more securely than desktop computers do)
- *Proxy* inbound IMAP and SMTP from users' mail clients
- Add and remove PGP encryption to emails as they pass through the proxy
- Advertise the user's public key in outbound emails
- Discover other users' public keys via inbound emails, keyservers and other means
- Automate key rotation

For example, I can set up a PGP proxy for my family and reconfigure the SMTP and IMAP settings in my family's mobiles and desktops to point at the proxy.

When my Dad sends my Mum and email, it goes like this:

- Dad's mail client connects to our PGP proxy via SMTP, authenticates somehow, delivers email to proxy
- PGP proxy attaches Dad's public key to outbound email
- PGP proxy finds Mum's public key (somehow)
- PGP proxy encrypts the email to Mum
- PGP proxy connects to Gmail via SMTP, authenticates with Dad's actual Gmail username & password, sends email

Mum's inbox now receives an encrypted email. This would look bad if she logged into webmail, but that's OK because her mail client & PGP proxy do a similar dance for receiving the email:

- Mum's mail client connects to PGP proxy via IMAP, authenticates somehow
- PGP proxy connects to Gmail using Mum's Gmail credentials
- PGP proxy downloads Dad's email, see that it's encrypted
- PGP proxy uses Mum's private key to decrypt email
- PGP proxy removes the attached public key and records it for later
- PGP proxy sends decrypted email via IMAP to Mum's mail client

Now Mum sees the exact same email that Dad originally sent. Neither knows that Google didn't get to read their email on this occasion.

## Problems

There are some problems with this scheme:

- It completely breaks webmail, and many people love Gmail's web interface.
- It requires someone setting up and running a PGP proxy, and keeping it safe. (Although it's probably easier to keep this safe than a desktop computer)

And probably a load more.

