---
title: 'GPG For Humans, Part 3: Protecting your Primary Key'
permalink: /gpg-for-humans-protecting-your-primary-key/
category: gpgforhumans
---
In the last post we talked about public and private, or secret, keys. The whole security of GPG relies on making sure your secret key can't be used by anyone else. In an Internet-connected world, this can be really tough. It's awkward to change keys, so ideally we'll keep the same key for years, if not decades.

GPG offers us a solution. In this post we're going to talk about splitting off your "primary" key and keeping it really safe, then using "subkeys" for every-day use.

## The All-Powerful Primary Key

When you create a GPG public/private keypair, by default you get a *primary* public/private key and one sub public/private key. The primary key has two capabilities, or permissions: Sign and Certify. The subkey has one capability: Encrypt.

    $ gpg --edit-key 0x309F635DAD1B5517
    Secret key is available.
    
    pub 4096R/0x309F635DAD1B5517 created: 2014-10-31 expires: 2015-10-31 usage: SC 
     trust: ultimate validity: ultimate
    sub 4096R/0x627B1B4E8E532C34 created: 2014-10-31 expires: 2015-10-31 usage: E


The trouble is, the primary key with its Certify capability is too powerful. If someone steals your primary key, the Certify capability allows them to certify other people's keys, they can generate new subkeys, revoke your keys and so on. They could even generate new subkeys and revoke your subkeys - totally stealing your identity!

In other words, your primary key is your *identity* - if the secret part is compromised, you'll need a new key. You can delegate some powers to your subkeys which you can take back at a future date.

Recall that last time we talked about comparing key *fingerprints* to verify key ownership. Although subkeys have fingerprints too, we're almost always talking about the primary key's fingerprint.

I don't want to carry around the all-powerful primary key on my laptop, phone etc. And that's OK - it's possible to remove the secret part of the primary key. But that leaves one problem - notice that the primary key provides both the Certify and Sign capability? Without it, I won't be able to *sign* things.

## Delegate to Subkeys

The solution is to create another subkey with the Sign capability and use the subkeys to make a new keyring for "every day" use. Your every-day keyring will *not* contain the secret part of your primary key.

So your set of keys will start off like this:

  * primary key (Sign, Certify)
  * subkey #1 (Encrypt)

Then you'll add a subkey:

  * primary key (Sign, Certify)
  * subkey #1 (Encrypt)
  * subkey #2 (Sign)

Then you'll convert this into an every-day keyring, which looks like:

  * primary key (without secret part - no capabilities)
  * subkey #1 (Encrypt)
  * subkey #2 (Sign)

The every-day keyring gives you signing and encryption capabilities but with these restrictions:

  * It cannot add or revoke any keys (including generating a revocation certificate)
  * It cannot certify other people's keys.

## Practise: Create An Every-Day Keyring

In the last post you generated a practice keyring. Here you can practise turning this into an every-day version without the secret part of the primary key.

This is just for fun and you shouldn't use these keys - we'll be going through this step-by-step in a later post.

First, add a Sign subkey:

    gpg --edit-key 0x309F635DAD1B5517
    Secret key is available.
    
    pub 4096R/0x309F635DAD1B5517 created: 2014-10-31 expires: 2015-10-31 usage: SC 
     trust: ultimate validity: ultimate
    sub 4096R/0x627B1B4E8E532C34 created: 2014-10-31 expires: 2015-10-31 usage: E
    
    gpg> addkey
    [... follow steps - set a short expiry ...]
    pub  4096R/0x309F635DAD1B5517  created: 2014-10-31  expires: 2015-10-31  usage: SC  
                                   trust: ultimate      validity: ultimate
    sub  4096R/0x627B1B4E8E532C34  created: 2014-10-31  expires: 2015-10-31  usage: E   
    sub  4096R/0x0AC6AD63E8E8A9B0  created: 2014-10-31  expires: 2015-10-31  usage: S   
    [ultimate] (1). Paul Michael Furley <paul@paulfurley.com>
    gpg> save


Success! Note that there's now a primary key - `pub` - and two subkeys - `sec`. See how the last key with id `0x0AC6AD63E8E8A9B0` has usage S which means Sign.

### Create a Full Backup

At this point we can make a **full** copy (backup) of our keyring (primary and subkeys, public and secret parts):

    $ gpg --export-secret-keys --armor 0x309F635DAD1B5517 > 0x309F635DAD1B5517.full_backup.asc


### Create a Partial Backup (Subkeys)

Now we can export the keyring *without* the secret part of the primary key. This will become our every-day keyring:

    $ gpg --export-secret-subkeys --armor 0x309F635DAD1B5517 > 0x309F635DAD1B5517.only_subkeys.asc


### Nuke Your GPG Directory

Move aside your `~/.gnupg/` directory to start afresh. You'll need to restore your `gpg.conf`:

    $ mv --no-clobber ~/.gnupg ~/.gnupg.BAK
    $ mkdir ~/.gnupg && cp ~/.gnupg.BAK/gpg.conf ~/.gnupg


### Import Your Partial Backup (Subkeys)

Finally, import your partial backup and peek at your secret keys:

    $ gpg --import 0x309F635DAD1B5517.only_subkeys.asc
    $ gpg --list-secret-keys gpg 0x309F635DAD1B5517
    sec#  4096R/0x309F635DAD1B5517 2014-10-31 [expires: 2015-10-31]
          Key fingerprint = A999 B749 8D1A 8DC4 73E5  3C92 309F 635D AD1B 5517
    uid                            Paul Michael Furley <paul@paulfurley.com>
    ssb   4096R/0x627B1B4E8E532C34 2014-10-31 [expires: 2015-10-31]
    ssb   4096R/0x0AC6AD63E8E8A9B0 2014-10-31 [expires: 2015-10-31]


Success! See how the `sec` has changed to `sec#` to signify that the secret key is missing.

Don't say I didn't warn you about GPG's UX...

## Lose Your Every-Day Keyring

Now, if your every-day keyring is lost and your subkeys are compromised, you resurrect your primary key and use it to revoke your subkeys and create new ones.

That's all very well, but how do we keep the primary key secure? For that, we're going to need an offline, or "airgapped" machine - meaning it has no connection to the Internet.

And that's the topic for next week.

## Homework!

  * Some more in-depth reading:
      * <https://apapadop.wordpress.com/2013/08/21/using-gnupg-with-qubesos/>
      * <http://spin.atomicobject.com/2013/11/24/secure-gpg-keys-guide/>
      * <http://security.stackexchange.com/a/31598>
  * Read up on Diceware passphrases at diceware.com
  * For the next post, you will need:
      * 2 computers - normal machine + a spare (2 is better but not essential)
      * 3x USB sticks (at least 4GB)
      * Ubuntu 14.04 LTS Desktop LiveCD installed on one of the USB sticks with no persistent storage

* * *

## Upcoming Ebook: I Need Your Help!

<div id="mc_embed_signup">
</div>