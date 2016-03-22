---
title: Hardening my Development Machine
permalink: /hardening-my-development-machine/
category: security
---

*This post describes ways that I've hardened my development machine against
attackers, without restricting my ability to do "risky" activities like
run other people's code. In short, it involves VMs, containers and a bit of
discipline.*

## Running Other People's Code is Essentail

As part of my work as a developer, I spent a lot of time testing out random
code from the Internet. Whether that be some fancy OCR code or a new Django
library, it's brilliant to be able to quickly spin up other people's code in
unfamiliar languages and have a play.

To me, this is what the Internet is all about; sharing scrappy ideas through
the medium of code.

The kind of code I'm talking about often isn't nicely packaged. It often hasn't
even been reviewed or tested - it's just there, take it or leave it.

## Current Operating Systems Are Too Permissive

The problem with running other people's code, at least with my current setup,
is that any code I run has exactly the same privilege as me.

For starters, any code I run can both read and write anything inside my home
directory, `/home/paul/`. It can read all my files - including those inside my
encfs encrypted filesystem. It can read my SSH & PGP keys, but that's OK,
because they're encrypted with a password, right?

Except, oh dear, it's running as me, so it can hang around and wait for me to
type in my password, then decrypt the underlying keys.

OK, it probably can't access "system" stuff on my filesystem - eg root-access
- stuff, because that requires me to type `sudo` and enter my password. But,
oops, we just learned that it can snoop my keyboard, so maybe it can after all.

Yes, maybe I've over-simplified it a bit, but essentially, anything I run as
me is *basically the same as me*.

Aside from all my data, if someone gains access to my SSH & PGP keys, they get
to totally impersonate me: they can trash servers I'm responsible for, they
can commit code as me and release malicious packages under my name, screwing
over my users.  As a developer, I have a responsibility to keep my users safe,
so I mustn't let this happen.

## Is There a Way to Safely Run Untrusted Code?

Clearly it's important to be able to run other people's code. It's not helpful
to say "don't run anything you don't trust" as trust is complex, and most of
the stuff on the Internet hasn't earned our trust, but that doesn't mean we
shouldn't be able to use it.

The question is, can we run other people's code without putting our own
data and identity at risk?

## Using Containers and Virtual Machines

We need a way to reduce the scope of what code is able to do, and modern
operating systems have a lot of things on offer.

These are the simple rules I use to harden my machine. Absolutely, this is by
no means perfect, but it's an excellent trade-off of usability and security,
and it's a lot less broken than it was before :)

### Do Development Inside a Virtual Machine

The biggest change to my way of working was moving *all* my development inside
a virtual machine.

I share my `~/repo/` directory through from the host machine to the virtual
machine, allowing me to edit code on the host machine and run it on the guest
machine.

It's important to be a bit limited about what you share into the virtual
machine - for example, don't share your whole home directory else you're
back in the same position!

I configure the machine using [Vagrant][vagrant] which gives me the extra
benefit of making it reproducible and throw-away - I can (and do) regularly
destroy the machine and rebuild it from scratch.

That also means I can more easily re-install my host machine, or move to
another operating system altogether, without having to work out how to rebuild
my dev machine each time.

Some tips:

- Limit what directories you share from the host to virtual machine
- Avoid using git inside the virtual machine: do that outside.
- Don't enable SSH forwarding as this allows a compromised virtual machine
  to impersonate your SSH identity.
- Configure the machine with code, so that it can be destroyed regularly.
- Destroy it regularly.
- Automate out anything you find annoying each time you rebuild the machine.
- Use a VM per project if it makes sense.

Feel free to rip of my [virtual machine config from Github.][github-vm-config]

### Keep My Host Machine Simple

Now I've got a throw-away virtual machine to mess around with, I've become a
lot stricter about the security of the host machine.

One of the best ways to reduce the "attack surface" - the number of possible
ways of attacking my machine - is to reduce the amount of code it runs overall,
or in other words, *keep it simple*.

Think twice before running `sudo` on the host machine.

### Use Only the System Package Manager

I've noticed more and more libraries whose install
instructions involve `curl` and `sudo bash`... eek.

I try to be strict about only installing packages through the system package
manager - in my case, `apt` on Ubuntu.

There are a number of benefits to only using the system package manager:

- Some level of vetting has happened by a competent person, in my case a Debian
  or Ubuntu package maintainer. Yes, they're often volunteers with little time
  but in my experience these fine folks care a *lot* about security.
- It's much easier to resolve "dependency hell" when you know what versions
  you're running.
- Packages installed through the package manager are more easily removed (at
  least when they're well behaved).

### Be Incredibly Selective About Third-Party Repositories

Conscientious organisations release their software in a number of native
package formats, for example .DEB on Debian, Ubuntu and co. They usually
combine this with running their own repositories (PPAs, whatever) which makes
life incredibly simple.

There's nothing wrong with using third-party repositories, but bear in mind
that these packages have root access on your machine, can automatically update
themselves, and are potentially completely unvetted.

Be aware of how much trust you are placing in the organisation's honesty *and*
ability to keep *their* machines secure. (If I were an attacker looking for
"value for money" I'd go after a popular PPA eg `python-opencv` that isn't
subject to the scrutiny of the Debian maintainers).

### Sandbox Mail Client and Web Browser

The last piece of the puzzle, at least for now, is hardening my web browser and
email client. Although I have trust in Mozilla Firefox and Thunderbird (perhaps
misplaced on the latter), when exploits are found they can be en masse,
for example through adverts placed on high profile websites.

This is especially true for the Tor Browser as most users run a single
version and all traffic passes through exit nodes, which can be compromised.

There's no reason for my browser to be able to read my SSH & PGP keys, so I run
it inside a neat containerising tool called [firejail][firejail]. This prevents it
from seeing other processes, files and so on outside of limits defined in its
"profile."

## Nope, It's Not Perfect

Sure, there are flaws. One is that I'm currently running Google Chrome for
work stuff and it doesn't play well with firejail. Oh, and it's installed from
a PPA, so Google has root on my machine. That needs some work.

Recently I've found myself thinking more and more, let's stop nitpicking
about *perfection*. At the moment, security of everything is basically s**t:
email, desktop computers, internet of things, it's all totally broken.

Let's strive to notch up from "shit" to "satisfactory", and go from there.


[vagrant]: https://www.vagrantup.com/downloads.html
[github-vm-config]: https://github.com/paulfurley/pauls-development-virtual-machine
[firejail]: https://firejail.wordpress.com/
