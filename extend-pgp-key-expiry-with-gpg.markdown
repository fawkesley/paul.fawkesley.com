---
title: How to extend PGP expiry date with GNU Privacy Guard
permalink: /extend-pgp-key-expiry-with-gpg/
layout: page
---

If you use [GNU Privacy Guard (GnuPG / GPG)][gnupg] to manage your PGP keys on the command-line, here's how to extend the primary key and a subkey for 3 months.

You'll need to replace my key fingerprint with your own (that's the long text starting `A999`).

## Extend your key expiry

Open up a command-line terminal and type the following:

```
$ gpg --quick-set-expire 'A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517' 3m
```

If that doesn't work, you may have an old version of GnuPG. Do this instead:

```
$ gpg --edit-key 'A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517'
key 0
expire
3m
y
[repeat for subkeys: key 1, key 2 etc...]
save
```

If you get stuck, see the [official GnuPG documentation.](https://www.gnupg.org/gph/en/manual.html#AEN329)


## Push it to the keyservers

Remember to push your updated key to the keyservers:

```
$ gpg --keyserver hkp://pool.sks-keyservers.net --send-keys 'A999 B749 8D1A 8DC4 73E5 3C92 309F 635D AD1B 5517'
```

## Remind your contacts to refresh their keys

Your contacts will need to refresh your key from the keyservers in order to be able to use your key again.

If a contact says your key has expired, you'll know what to tell them.

{% include help_support_expirybot.markdown %}

[gnupg]: https://gnupg.org/
