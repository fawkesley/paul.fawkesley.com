---
date: "2015-02-03"
title: 'GPG For Humans, Part 4: Preparing an Offline Machine'
permalink: /gpg-for-humans-preparing-an-offline-machine/
category: gpgforhumans
---
Last time we talked about the importance of protecting your primary secret key as, if stolen, an attacker could take over your entire GPG identity.

An effective way to protect your key is a combination of techniques:

  * **make sure that it never touches a network**
  * **store the key encrypted with a strong passphrase**

Of course, this isn't foolproof, but it significantly ups the game. An attacker would now have to both steal the key - probably by physically breaking in to your property - and also decrypt it.

# Memory Sticks are Cheap

We're going to be using a LiveCD and three USB memory sticks for our offline machine. To aid your future self, I recommend that you find a marker pen and label them.

Mine are labelled like this:

  1. LIVE CD
  2. GPG KEYS (ONLY CONNECT TO OFFLINE LIVE CD)
  3. TRANSFER

# Time for some Diceware

Since you've learned all about [Diceware][1], it's time to roll some die and create a new passphrase.

This **offline passphrase**: will protect your `GPG KEYS` memory stick, and must only *ever* be typed into an offline Live CD.

You're probably going to need to write down a backup and hide it in a different location from the memory stick.

# 1. A LiveCD Always Forgets

A Live "CD" is a GNU/Linux distribution which boots directly from a CD or USB stick and keeps everything in random-access memory (RAM) - that is, nothing is ever written to permanent storage.

That's great for a number of reasons:

  * each boot is a fresh start, making it difficult for an attacker to install keyloggers or malware
  * there are (ideally) no permanent storage media for secret keys to leak onto

I used the "Startup Disk Creator" application in Ubuntu to build an [Ubuntu][2] 14.04LTS Desktop bootable USB stick.

**Warning: You must disable writeable "reserved space" on the USB stick** - in my application I had to select an option called "Discarded on shutdown, unless you save them elsewhere".

If your USB stick has a read-only hardware switch, it's a good idea to enable it after creating your LiveCD.

# 2. GPG Keys

The purpose of this memory stick is to store an export of your primary key and all subkeys, as well as a copy of your `gpg.conf`.

This memory stick holds the keys to the kingdom, so it's a great idea to encrypt the underlying partition before you write anything to it. You can do this by booting into your LiveCD and opening its "Disk Utility" application. From there you can erase the USB stick and create a new LUKS encrypted partition.

You'll be prompted for a passphrase. Now's the time to use your **offline passphrase**. Remember, you should only type this into a LiveCD that's not connected to a network.

# 3. Transfer

This memory stick is going to move things between your online and offline machines. A few examples include:

  * Other people's public keys that you want to certify (sign) will be copied to your offline machine, certified, then transferred back online to be sent to the owner.
  * Your "every day" keyring, comprising only your subkeys, will be copied to your online machine.

It's up to you whether you encrypt this memory stick, but if you do, **don't use the offline passphrase** as that would indirectly expose that passphrase to your online machine.

# Transfer is a Weak Link

Beware: because it moves between your online and offline machines, this memory stick is a serious candidate for attack.

For example, a determined attacker with control of your online machine could install malicious software onto the memory stick that exploits a weakness in the offline machine, for example in its file manager (nautilus). The software could be programmed to extract GPG keys and copy them onto the memory stick in a hidden location. Then when the transfer memory stick moves between machines it could exfiltrate your secret key.

To reduce this risk, you could use a memory stick with a read-only switch which is always enabled when connected to the offline machine. This would prevent malicious software running on the offline machine from writing secret keys to the memory stick, but also limits the transfer to one direction. Your mileage may vary, and I'd appreciate your views on this one.

Pragmatically, you probably need two-way transfer, so just exercise caution with how you use this memory stick - don't ever run software from it, for example.

# Creating Your Offline Machine

Old laptops make great offline machines, especially if you can remove all permanent storage such as hard drives and SD cards.

![Offline laptop][3]

Removing permanent storage reduces the number of channels through which your secret key could be exfiltrated (malicious software could copy your keys onto the hard drive in the hope that you'll later boot the laptop online where it could be retrieved through hacking).

So, with old laptop in hand, here's how to get your new secure machine ready for primetime.

## Preparing the laptop

  1. Switch off and remove hard drive from offline machine.
  2. Disconnect and disable any network devices - preferably physically and also in BIOS.
  3. Enable booting from USB in the BIOS, if required.
  4. Insert `LIVE CD` memory stick and power up.
  5. Marvel at the idea that anything you do here will be lost when you power off!

## Preparing GPG KEYS memory stick

  * Insert `GPG KEYS` memory into offline LiveCD laptop
  * Run Disk Utility
  * Format the memory stick and create a LUKS parition, using the offline passphrase.
  * Eject and remove `GPG KEYS` memory stick
  * Re-insert and verify that you are prompted for a passphrase, and your offline passphrase unlocks it

## Preparing gpg.conf

Because every boot is a fresh start, you'll need to keep a copy of your `gpg.conf` file so that GPG is sanely configured (see previous post).

As your GPG config file may be an avenue for attack, I recommend keeping it on your `GPG KEYS` memory stick.

  * Start up your offline LiveCD and unlock your `GPG KEYS` memory stick.
  * Open a terminal and type `gpg` to generate a default `~/.gnupg/gpg.conf` file
  * Edit `~/.gnupg/gpg.conf` according to the [https://paulfurley.com/gpg-for-humans-public-key-crypto-primer/][4]. **This file is currently in memory, and will be lost on reboot**
  * Copy the newly edited `~/.gnupg/gpg.conf` to your `GPG KEYS` memory stick, eg `/media/ubuntu/GPG_KEYS/gpg.conf`

# Daily Use

When you want to use GPG on the laptop, you'll need to restore your GPG configuration and keys as the machine will be totally fresh. You can do this by following these steps:

  1. Unplug everything, disable network devices, remove all disks and memory sticks.
  2. Insert `LIVE CD` memory stick and power on.
  3. Insert `GPG KEYS` memory stick and unlock with secure passphrase
  4. Copy `/media/ubuntu/GPG_KEYS/gpg.conf` to `~/.gnupg/` directory
  5. Import your GPG keys, eg `gpg --import /media/ubuntu/GPG_KEYS/0x309F635DAD1B5517.full_backup.asc`
  6. Unmount and eject your `GPG KEYS` memory stick.
  7. Do some GPG stuff.
  8. **Power off** to wipe the laptop's memory.

To minimise the risk of data leaking, you need to bear in mind a few simple rules. You might even want to print these and stick them to your laptop.

  1. Your `GPG KEYS` memory stick must only be inserted into your freshly-booted, offline LiveCD.
  2. Ditto for your secure passphrase.
  3. Unmount and remove `GPG KEYS` as soon as you've imported your configuration and keys.
  4. Always power off (not suspend) the laptop as soon as you've finished what you're doing.

# Bringing it all together

It's been a long time coming, but that's the background covered.

Next time we'll actually create a set of GPG keys using the offline machine, storing them securely on a dedicated memory stick.

# Homework

  * Find somewhere safe to hide your `GPG KEYS` memory stick.
  * Seal your passphrase in an envelope and hide it somewhere - in a different location from `GPG KEYS` !
  * Help me out with a potential ebook - see below.

# Ebook

I'm considering writing an Ebook on GPG - can you help? I'd like to pin down what areas to focus on so your feedback would amazing. I'll make sure you get a free copy.

[Contribute and get occasional updates on a GPG ebook.][5]

 [1]: http://diceware.com
 [2]: http://www.ubuntu.com/download/desktop
 [4]: homework section in part 2
 [5]: http://eepurl.com/bbooor
