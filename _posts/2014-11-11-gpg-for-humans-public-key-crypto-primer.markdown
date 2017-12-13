---
title: 'GPG For Humans, Part 2: Public Key Crypto Primer'
permalink: /gpg-for-humans-public-key-crypto-primer/
category: gpgforhumans
---
Public-key or "asymmetric" crypto is a cunning piece of maths (which I happily
don't understand) that's at the heart of GPG. The incredible thing it allows is
for us to communicate securely (signing and encryption) without having agreed a
secret in advance. This turns out to be a big deal.

In GPG you create a *pair* of keys which are fundamentally related. One half is your *secret* or *private* key, which you keep strictly to yourself. The other half is your *public* key which you tell everyone about, if you so wish.

This brings us back to <a title="GPG For Humans, Part 1: Why Care About Cryptography?" href="https://paulfurley.com/gpg-for-humans-why-care-about-cryptography/" target="_blank">part 1</a> on signing and encryption. If I know your *public* key, I can use it to encrypt a message that only your *secret* key can unlock. Even I can't unlock it once I've encrypted it.

Furthermore, you can use your secret key to create a signature. If I know your public key then I can verify that the signature came from your secret key by using your public key.

  * **public key** - encrypt messages to owner, verify signatures by owner
  * **secret key** - decrypt messages to owner, create signatures by owner

Clearly, it's very important to properly verify that a public key belongs to who you think it does. There is absolutely nothing to stop someone from creating a keypair using someone else's email address and pretend it really belongs to that person. In fact, this isn't theoretical - it has actually happened to developers. We'll go into key verification in more detail later - for now, suffice to say that public keys have *fingerprints* which must be carefully verified, preferably in person.

So what's a fingerprint?

## Key IDs & Fingerprints

Unfortunately GPG has three (at least?) ways of identifying a key. Here are the three ways for my current public key:

1. Short ID, for example `AD1B5517`
2. Long ID, for example `0x309F635DAD1B5517`
3. Fingerprint, for example `A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517`

To cut a long story short, *don't ever use short ids* - <a href="http://yro.slashdot.org/story/11/12/27/0044242/gnupg-short-id-collision-has-occurred" target="_blank">they are not secure</a>. But do be aware of them as you are likely to encounter them - alas, not everyone is using long ids yet <img src="https://paulfurley.com/wp-includes/images/smilies/icon_sad.gif" alt=":(" class="wp-smiley" />

The fingerprint is what you use to compare and verify a key. Supposing you knew me well enough to identify me in person. It would be fairly easy to acquire and verify my public key, perhaps like this:

1. You search a keyserver for my email address, and it shows you a key with id `0x309F635DAD1B5517`
2. You download key `0x309F635DAD1B5517` and examine its fingerprint
3. You meet me (in person) and ask me to read my key's fingerprint.
4. You verify every single digit of the fingerprint.
5. You *sign* my key to say that you've verified it belongs to me.

In this ideal scenario, you'd have a pretty good idea that I owned the public key you'd just downloaded. Now you could send me an encrypted email or verify a message or file that I've signed.

## Keyservers

Keyservers are a way of sharing public keys and knowledge of who has verified which keys. We'll cover these more later, but for now a word of warning: you cannot delete keys from a keyserver, so they will hang around forever. It's possible to expire and revoke them, but they'll still be present in search results. I would advise that you don't send any keys to a keyserver just yet.

## Homework!

Enough theory - let's get stuck in! There are loads of resources online to help. Don't worry about security at this point - we'll be doing secure key generation step-by-step later on.

  1. Configure gnupg.conf to show long ids and fingerprints (see <a href="https://help.riseup.net/en/security/message-security/openpgp/best-practices" target="_blank">https://help.riseup.net/en/security/message-security/openpgp/best-practices</a>)
  2. Generate an RSA key pair with 4096 bits and an expiry of one week.
  3. Have a play with `` `gpg --list-keys` `` and `` `gpg --edit-key <long id>` ``
  4. Try and find & download my key from a keyserver using paul@paulfurley.com (hint: `` `--search-keys` `` and `` `--recv-keys` ``)

Any thoughts, <a title="Contact" href="https://paulfurley.com/contact/" target="_blank">get in touch</a>.