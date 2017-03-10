---
title: "The Internet Freedom Festival 2017 (Wednesday)"
permalink: /internet-freedom-festival-2017-wednesday/
category: iff2017, internetfreedom, security
---

Wednesday was stimulating, exciting, then overwhelming, but excellent.

For the first time I felt I belong in this community, I understand its challenges, and I've got something to contribute.

That was cool.

## Turkey blocks

In [this session][turkey-blocks-session], the cool folks at [Turkey blocks][turkey-blocks] showed off their realtime censorship-detection system.

This started following a terrorist attack, when the government unhelpfully shut down the internet. That made it impossible for people to contact loved ones at the time of greatest need. Since then, shutdowns have occurred at various times and Turkey Blocks have [documented them][turkey-blocks-reports].

![Tweet from @TurkeyBlocks showing twitter, youtube and facebook being down](/img/turkey-blocks-twitter.png){: .img-responsive }
*Turkey Blocks control the online dialog by detecting and reacting quicker than others.*

An interesting technical point is that the method used to censor websites is injecting retransmission packets into TCP streams, disrupting the stream and throttling the connection. As this makes sites unusuable in practice, it's censorship, even if some prefer the word "throttling".

They use packet captures from [Wireshark][wireshark] to both analyse and *illustrate* that stream tampering is going on.

[turkey-blocks-session]: https://internetfreedomfestival.org/wiki/index.php/Post-Truth_Censorship:_New_Techniques_for_Realtime_Shutdown_Detection
[turkey-blocks]: https://turkeyblocks.org/
[turkey-blocks-reports]: https://turkeyblocks.org/reports/
[wireshark]: https://www.wireshark.org/

## Cat and mouse with deep packet inspection

In this [session][cat-and-mouse-session] we learned about ways of simulating censorship on a local machine in order to test circumvention techniques.

As circumvention techniques improve, the censors adapt with more eleborate detection techniques, in a game of "cat and mouse".

[Stegotorus][stegotorus] offers a solution: make it easier for developers for create new techniques quickly. These techniques are called "pluggable transports" and the theory goes that if developers can bash out a few way over the weekend, it creates an unmanageable workload for the censors.

That's an elegant case where a decentralised model can defeat a centralised one: the internet community can create a large workload for the censors in a sort of denial of service attack.

![Stegotorus client to server connection, then to Tor network](/img/stegotorus-diagram.png){: .img-responsive }
*Stegotorus diagram from https://sri-csl.github.io/stegotorus/*

[cat-and-mouse-session]: https://internetfreedomfestival.org/wiki/index.php/Playing_cat_and_mouse_with_Deep_Packet_Inspection
[stegotorus]: https://sri-csl.github.io/stegotorus/

## Pluggable Transports Lunch

That session led on to lunch with the [pluggable transports community][pluggable-transports]: a highly capable (and welcoming) group of individuals all working towards the same goal of building circumvention tools.

This one was pretty tough on the brain, with some extremely sharp folks from [Operator Foundation][operator-foundation], [Jigsaw][jigsaw], [Internews][internews] and others whose organisations I didn't catch.

This community has produced a Pluggable Transport 2.0 specification which is an effort to bring together the community's individual efforts.

To make it more concrete: suppose you develop an Android app which talks to a backend server. One day you find that your app no longer works in Iran, what do you do? The vision of this community is that you search how to get round filtered internet, find the pluggable transports and do three things:

1. add a library to your Android build manifest
2. add a line to your backend server Ansible config
3. add a line of code to your app to handle a socket failure, switching to pluggable transports

Cool.

[pluggable-transports]: https://www.pluggabletransports.info/
[operator-foundation]: https://operatorfoundation.org/
[jigsaw]: https://jigsaw.google.com
[internews]: https://www.internews.org/

## Idea: Zero-config Tor Bridges in the Home

... talked to someone from the Tor project about this, seems promising...

## Autocrypt: Email Encryption for Everyone

I tried to go [this session][autocrypt-session] but it was so full I couldn't fit in the room!

Have a look at the [autocrypt spec][autocrypt-spec], it feels like a very promising approach to email encryption.

[autocrypt-session]: https://internetfreedomfestival.org/wiki/index.php/Autocrypt:_Email_Encryption_for_Everyone
[autocrypt-spec]: https://autocrypt.readthedocs.io/

## Human rights in Venezuela

I had a long, distressing, but inspiring talk with an incredibly brave human rights worker from Venezuela. His challenges made things very real: people close to him have been kidnapped repeatedly until they left the country.

Digital security is a matter of life and death for him. Before we left I taught him about two-factor authentication on Google, which he was very excited about...

## Secure communication and information management in rural areas

In this [session][rural-areas-session] we broke out into groups and tackled specific problems people in that group are facing. In our case we were working on how to bring low cost internet to Gambia, a recent democracy with no rural internet infrastructure.

They've got an interesting opportunity to use neighbouring Senegal, which is geographically close, more or less wherever you are in Gambia.

Currently NGOs buy Senegalese SIM cards and bring them into Gambia, but the cost of data is huge, making it prohibitive.

We talked about compressing data using [Opera Mini][opera-mini] and creating a line-of-site microwave link from a fixed-line connection in Senegal, as well as mesh networks, like the [altermundi][altermundi] community we met at [last year's IFF][mesh-network-session-2016].

[rural-areas-session]: https://internetfreedomfestival.org/wiki/index.php/Secure_communication_and_information_management_in_rural_areas
[opera-mini]: http://www.opera.com/mobile
[altermundi]: http://www.altermundi.net/
[mesh-network-session-2016]: https://www.internetfreedomfestival.org/wiki/index.php/Autonomous_Wireless_and_GSM_Networks


[Get in touch.][paul-twitter]
[IFF on Twitter][iff-twitter]


[iff]: https://internetfreedomfestival.org/
[iff-twitter]: https://twitter.com/internetff
[paul-twitter]: https://twitter.com/paul_furley
