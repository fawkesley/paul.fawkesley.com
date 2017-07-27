---
title: How to extend PGP expiry date with GNU Privacy Guard
permalink: /extend-pgp-key-expiry-with-gpg/
layout: page
---

If you use [GNU Privacy Guard (GnuPG / GPG)][gnupg] to manage your PGP keys on the command-line, here's how to extend the primary key and a subkey for 3 months.

You'll need to replace my key fingerprint with your own (that's the long text starting `A999`).

Open up a command-line terminal and type the following:

```
$ gpg --edit-key 'A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517'
key 0
expire
3m
y
[repeat for subkeys: key 1, key 2 etc...]
save
```

Remember to push your updated key to the keyservers:

```
$ gpg --send-keys 'A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517'
```

Your contacts will need to refresh your key from the keyservers in order to be able to use your key again.

{% include pgp_user_research_callout.markdown %}

*Was this helpful?* I'd love to [hear from you!][email]

[gnupg]: https://gnupg.org/
[email]: mailto:paul@paulfurley.com
