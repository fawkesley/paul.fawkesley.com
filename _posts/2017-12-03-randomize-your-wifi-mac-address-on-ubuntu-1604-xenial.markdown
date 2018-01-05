---
title: "Randomize your WiFi MAC address on Ubuntu 16.04"
snappy_title: "Randomize your WiFi MAC address on Ubuntu 16.04"
permalink: /randomize-your-wifi-mac-address-on-ubuntu-1604-xenial/
category: security
is_highlighted: true
image: terminal-window-nmcli-commands.png
---

*Your device's MAC address can be used to track you across the WiFi networks you connect to. That data can be shared and sold, and often identifies you as an individual. It's possible to limit this tracking by using pseudo-random MAC addresses.*

<!--more-->

![A captive portal screen for a hotel allowing you to log in with social media for an hour of free WiFi](/img/captive-portal-our-hotel.gif){: .img-responsive }

*Image courtesy of [Cloudessa](http://cloudessa.com/products/cloudessa-aaa-and-captive-portal-cloud-service/)*

Every network device like a WiFi or Ethernet card has a unique identifier called a MAC address, for example `b4:b6:76:31:8c:ff`. It's how networking works: any time you connect to a WiFi network, the router uses that address to send and receive packets to your machine and distinguish it from other devices in the area.

The snag with this design is that your unique, unchanging MAC address is just perfect for tracking you. Logged into Starbucks WiFi? Noted. London Underground? Logged.

If you've ever put your real name into one of those Craptive Portals on a WiFi network you've now tied your identity to that MAC address. Didn't read the terms and conditions? You might assume that free airport WiFi is subsidised by flogging 'customer analytics' (your personal information) to hotels, restaurant chains and whomever else wants to know about you.

I don't subscribe to being tracked and sold by mega-corps, so I spent a few hours hacking a solution.


## MAC addresses don't need to stay the same

Fortunately, it's possible to spoof your MAC address to a random one without fundamentally breaking networking.

I wanted to randomize my MAC address, but with three particular caveats:

1.  The MAC should be **different across different networks.** This means Starbucks WiFi sees a different MAC from London Underground, preventing linking my identity across different providers.
2.  The MAC should **change regularly** to prevent a network knowing that I'm the same person who walked past 75 times over the last year.
3.  The MAC **stays the same throughout each working day**. When the MAC address changes, most networks will kick you off, and those with Craptive Portals will usually make you sign in again - annoying.


## Manipulating NetworkManager

My first attempt of using the `macchanger` tool was unsuccessful as NetworkManager would override the MAC address according to its own configuration.

I learned that NetworkManager 1.4.1+ can do MAC address randomization right out the box. If you're using Ubuntu 17.04 upwards, you can get most of the way with [this config file](https://gist.github.com/paulfurley/978d4e2e0cceb41d67d017a668106c53/). You can't quite achieve all three of my requirements (you must choose _random_ or _stable_ but it seems you can't do _stable-for-one-day_).

Since I'm sticking with Ubuntu 16.04 which ships with NetworkManager 1.2, I couldn't make use of the new functionality. Supposedly there is some randomization support but I failed to actually make it work, so I scripted up a solution instead.

Fortunately NetworkManager 1.2 does allow for spoofing your MAC address. You can see this in the 'Edit connections' dialog for a given network:


![Screenshot of NetworkManager's edit connection dialog, showing a text entry for a cloned mac address](/img/network-manager-cloned-mac-address.png){: .img-responsive }

NetworkManager also supports hooks - any script placed in `/etc/NetworkManager/dispatcher.d/pre-up.d/` is run before a connection is brought up.


## Assigning pseudo-random MAC addresses

To recap, I wanted to generate random MAC addresses based on the _network_ and the _date_. We can use the NetworkManager command line, nmcli, to show a full list of networks:


```
> nmcli connection
NAME                 UUID                                  TYPE             DEVICE
Gladstone Guest      618545ca-d81a-11e7-a2a4-271245e11a45  802-11-wireless  wlp1s0
DoESDinky            6e47c080-d81a-11e7-9921-87bc56777256  802-11-wireless  --
PublicWiFi           79282c10-d81a-11e7-87cb-6341829c2a54  802-11-wireless  --
virgintrainswifi     7d0c57de-d81a-11e7-9bae-5be89b161d22  802-11-wireless  --
```


Since each network has a unique identifier, to achieve my scheme I just concatenated the UUID with today's date and hashed the result:

```

# eg 618545ca-d81a-11e7-a2a4-271245e11a45-2017-12-03

> echo -n "${UUID}-$(date +%F)" | md5sum

53594de990e92f9b914a723208f22b3f  -

```

That produced bytes which can be substituted in for the last octets of the MAC address.

Note that the first byte `02` signifies the address is [locally administered](https://en.wikipedia.org/wiki/MAC_address#Universal_vs._local). Real, burned-in MAC addresses start with 3 bytes designing their manufacturer, for example `b4:b6:76` for Intel.

It's possible that some routers may reject locally administered MACs but I haven't encountered that yet.

On every connection up, the script calls `nmcli` to set the spoofed MAC address for every connection:

![A terminal window show a number of nmcli command line calls](/img/terminal-window-nmcli-commands.png){: .img-responsive }

As a final check, if I look at `ifconfig` I can see that the `HWaddr` is the spoofed one, not my real MAC address:

```
> ifconfig
wlp1s0    Link encap:Ethernet  HWaddr b4:b6:76:45:64:4d
          inet addr:192.168.0.86  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::648c:aff2:9a9d:764/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12107812 errors:0 dropped:2 overruns:0 frame:0
          TX packets:18332141 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:11627977017 (11.6 GB)  TX bytes:20700627733 (20.7 GB)
```

The full script is [available on Github](https://gist.github.com/paulfurley/46e0547ce5c5ea7eabeaef50dbacef3f).

<script src="https://gist.github.com/paulfurley/46e0547ce5c5ea7eabeaef50dbacef3f.js"></script>

Enjoy!

*Update: [Use locally administered MAC addresses](https://gist.github.com/paulfurley/46e0547ce5c5ea7eabeaef50dbacef3f/revisions#diff-824d510864d58c07df01102a8f53faef) to avoid clashing with real Intel ones. Thanks [@_fink](https://twitter.com/fink_/status/937305600005943296)*

[Thoughts? Get in touch.][paul-twitter]

[paul-twitter]: https://twitter.com/paul_furley


