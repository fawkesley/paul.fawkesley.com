---
title: 'GPG For Humans, Part 1: Why Care About Cryptography?'
snappy_title: "GPG For Humans, Part 1"
permalink: /gpg-for-humans-why-care-about-cryptography/
redirect_from: "/gpg-for-humans/"
is_highlighted: false
image: gpg-for-humans-thumbnail.png
category: gpgforhumans

---
Cryptography, or crypto for short, offers myriad benefits far beyond writing secret messages. Crytography is already in massive, widespread use, underpinning many industries such as finance, law and journalism, as well as creative systems like the Bitcoin crypto currency.

Today, many of us are using crypto as a *side-effect* of systems we are using, but very few are using cryptography *directly*.

In this post I'm going to highlight some empowering use cases and in the following series I'll be sharing my journey into re-learning and understanding <a href="https://www.gnupg.org/" target="_blank">GPG</a> - the awkward but most widespread crypto package currently in use.

## What Can GPG Actually Do?

Conceptually, GPG allows you to do a few different things:

  * **Sign** things to prove to other people that they have not been tampered with.
  * **Verify** things that have been signed by other people.
  * **Encrypt** and **Decrypt** things to limit who can access them.

### Cryptographic Signing

Have you ever downloaded software from the Internet? If so, how did you know that the software package you downloaded was the same as what the developer published? What if their server had been hacked and the software was modified somehow?

Have you ever published any software? Your users might appreciate being able to verify it really came from *you*.

It struck me how important this was when I first downloaded <a title="Tor Project" href="https://www.torproject.org/" target="_blank">Tor, or The Onion Router</a> *(as an aside, I'd recommend you go and try it out, it's a fascinating piece of software and it's cool how Google keeps changing language!)*.

Originally funded by the US Government, Tor empowers journalists, lawyers, you, me and anyone else to browse the Internet in a way which is difficult to snoop on. This upsets regimes that like to snoop on everyone. I conclude that this makes Tor a likely candidate for someone to want to tamper with.

GPG offers a solution. By *signing* the package, the Tor developers can tell me *exactly* what the package looked like when they created it. As long as I can verify their signature (more on that later), I know the software has not been tampered with.

### Encryption

So why bother with encryption?

Have you ever written a diary? Taken a private photo? Ever written down a sexual fantasy?

Personally I'm proud to have secrets and I have things I want to hide (see <a href="https://en.wikipedia.org/wiki/Nothing_to_hide_argument" target="_blank">https://en.wikipedia.org/wiki/Nothing_to_hide_argument</a>). In the past, we kept our secrets by storing them in a safe place, often with a lock and key.

I adore the Internet, but alongside its huge benefits, it's made everything *so leaky*. It's *really* hard to keep secrets when everything is so well connected - and getting ever more connected.

Encryption empowers *you* to decide what is visible to others. With encryption, you don't need to trust a company's Privacy Settings. It doesn't matter if your email provider's IT support team peer inside your inbox. With encryption - done properly - you become the guardian of your diary, photos, fantasies, and anything else you choose.

## Aims & Audience

My medium-term aim is for more people to be confident using GPG and this means starting with technical users (those who are confident with the command-line).

The long-term aim is to help GPG evolve into something *far* more user-friendly that's accessible by the majority.

This will be a series of blog posts. Once complete, they should provide a step-by-step guide to understanding GPG enough to it use confidently.

There is always a trade-off between convenience and security and it's important to understand those trade-offs. Personally I want my GPG identity to remain mine, and only mine, for many years. Therefore I will be erring on the side of security and advocating strong security practices such as Diceware passphrases, offline laptops and so on.

You *do not* have to be a crypto expert. You might have used GPG casually, but perhaps don't currently understand it well enough to use confidently on a daily basis. That's basically me at the start of this process - I'm learning too.

I'll collate and follow the best guidance I can find, and relay it in a human-friendly way. You can feed back with corrections and ideas.

**Is this a worthwhile project? [Let me know.][1]**

 [1]: https://paulfurley.com/contact/ "Contact"
