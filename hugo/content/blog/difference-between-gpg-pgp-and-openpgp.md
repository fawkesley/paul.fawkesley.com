---
date: "2015-03-31"
title: The Difference Between GPG, GnuPG, PGP and OpenPGP
permalink: /difference-between-gpg-pgp-and-openpgp/
---

This seems to come up a *lot* - is it a PGP key or a GPG key, and what's OpenPGP?

Don't worry, it's simple, and best explained with a brief timeline:

## Pretty Good Privacy (PGP)

Pretty Good Privacy is *proprietary software* and was originally written by [Phil Zimmerman][phil-zimmerman] in 1991. After several changes of hands, it's now owed by Symantec Corp. They also own the registered trademark for "PGP", "Pretty Good" and "Pretty Good Privacy".

## OpenPGP

After PGP took off in popularity, others wanted to write software that was compatible with the PGP format.

In 1997 PGP Inc proposed to the IETF a standard called OpenPGP and allowed various uses of the name "OpenPGP". This was accepted and the IETF formed the OpenPGP Working Group.

The OpenPGP protocol is currently formalised in the (obsolete) [RFC 2440][rfc-2440] and new [RFC 4880][rfc-4880].


## GNU Privacy Guard (GnuPG / GPG)

[GNU Privacy Guard][gnupg], also known as GnuPG and GPG, is the [Free Software Foundation][fsf]'s implementation of the OpenPGP protocol, written almost entirely by [Werner Koch][werner-koch].

As it is entirely Free Software (licensed under GNU Public Licence v3), you are granted the freedom to inspect and modify the source code [(see my mirror
here)][gnupg-mirror]. Furthermore, accordingly, some versions do not include proprietary "encumbered" algorithms such as IDEA.

## What to call my key?

Lots of people call their key-pair a "PGP Key" but given that "PGP" is trade-marked, that doesn't seem right. And if it was generated with GnuPG or some other OpenPGP implementation, that seems daft.

"GPG key" is popular too, but unless a key is specific to GnuPG, that seems wrong.

So in my opinion, it's probably right to call it an "OpenPGP Key", but I'm not sure everyone will agree with me on that one!

## Other OpenPGP implementations

There are lots of OpenPGP implementations and the one I'm currently 2nd-most excited about is [openpgpjs][openpgpjs] for Javascript. Doing grown-up encryption in the browser excites me as someone's got a *chance* of building something *pretty*. And seriously, I think that's important if we want encryption to be used by people less geeky than me.

The one I'm most excited about is my very own [EncryptIt][encryptit] for Python, focusing (predictably) on testing and clarity. It's early days and it's by no means the most complete, but I'm taking it deliberately slow to keep the quality high.

**Interested in learning how to use GPG? See my [GPG For Humans](https://paulfurley.com/gpg-for-humans-why-care-about-cryptography/) series.**

[phil-zimmerman]: https://en.wikipedia.org/wiki/Phil_Zimmermann
[rfc-2440]: https://tools.ietf.org/html/rfc2440
[rfc-4880]: https://tools.ietf.org/html/rfc4880
[fsf]: https://fsf.org
[gnupg]: https://gnupg.org
[gnupg-mirror]: https://github.com/fawkesley/gnupg-mirror/
[werner-koch]: https://en.wikipedia.org/wiki/Werner_Koch
[openpgpjs]: https://github.com/openpgpjs/openpgpjs
[encryptit]: https://github.com/fawkesley/encryptit
