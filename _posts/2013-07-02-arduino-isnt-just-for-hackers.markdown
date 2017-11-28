---
title: "Arduino Isn't Just For Hackers"
snappy_title: "Arduino Isn't Just For Hackers"
permalink: /arduino-isnt-just-for-hackers/
is_highlighted: true
image: picocolour-printing-machine.jpg
bfa_virtual_template:
  - hierarchy
sfw_pwd:
  - QkXNXtg4Q9jJ
category: arduinoraspberrypi
---
*[Arduino](http://www.arduino.cc) turned out to be the perfect match for <a title="JF Machines Ltd, digital inkjet printing machine manufacturers" href="http://www.jfmachines.co.uk" target="_blank">JF Machines Ltd</a>, a manufacturer of industrial digital printing machines. The open source platform offered them supply security, enormous flexibility and simple PC interfacing, all at an incredible price.*

Back in 2009 I worked in JF Machines Ltd - the family firm - producing the user operator software for their new digital printing machine, the PicoColour (if you're imaging a desktop printer, try 1.5 tonnes of precision-engineered printing press...)

![PicoColour digital inkjet printing machine](/img/picocolour-printing-machine.jpg){: .img-responsive }

*Picocolour digital inkjet printing machine*

Like many high-tech manufacturers, JF Machines has historically used both in-house electronics and programmable logic controllers (PLCs). As a quick primer, PLCs are proprietary devices which typically employ a high level language - or even graphical user interface - to describe complex system behaviour. For example, one might use BASIC to set up timers and state machines, then define how the system output responds to input signals.

The PLC is a great sell: simple machine control, little hardware design required and so on, but the flaws soon become apparent.

Firstly they bring about the familiar situation of vendor lock in. Once you've committed to a PLC, you go off and design a whole load of other electronics around it. A couple of years down the line, the vendor discontinues the PLC, or worse, goes bust, and you're in trouble. If you're lucky they've produced an updated "equivalent" but it's a miracle if it's a real "drop-in" replacement.

Furthermore, your software - often just block diagrams inside a proprietary software package - has become as useful as the obsolete PLC it's written for. Simple servicing operations turn into a major hardware and software development exercise,leaving machines in the field vulnerable to failure. Add to this the fact that PLCs can cost thousands of pounds in the first place, and you can see why companies often develop a love-hate relationship with them.

Enter <a title="Arduino" href="http://geni.us/2s6n" target="_new">Arduino</a>. I'd been hacking around with Arduino since my <a title="Cooperative Mobile Robots, MEng project" href="http://paulfurley.com/cooperative-mobile-robots-meng-project/" target="_blank">masters project</a> and it came along at a perfect time for JF Machines. They had just developed their new ink circulation system: a serious affair with 5 separate ink bottles rising and falling to alter  pressure along with precise temperature control. They needed a way to drive the bottle lifting motors, read in alarm signals and switch inputs as well as output various flashing sequences for the benefit of the operator. Although a PLC would have been suitable, Arduino seemed like a great option.

The image below shows the PCB which was developed to accommodate five unmodified Arduino boards.

![Four arduinos connected to a PCB](/img/four-arduinos-in-a-pcb.jpg){: .img-responsive }

As time has gone on, it has become more and more convincing that this approach was a solid one. Here I outline a few of the major benefits of using Arduino in this industrial setting.

**Supply security** - even if Arduino stopped supplying boards tomorrow, other manufacturers are making clones, and the hardware design lives on. If Arduino changed their physical design, it wouldn't be much trouble to make a converter to adapt the new and old sockets - in fact, someone would probably release it was an off-the-shelf project as soon as the announcement was made! In the worst case scenario, JF Machines could manufacture the whole Arduino board from the designs for as long as the a compatible microcontroller remained available.

**Flexibility** - since developing the ink system, JF Machines has found a number of new applications for the Arduino. For example, by giving Arduino the ability to override the input to the machine's main stepper motor, they were able to make the machine reverse after stopping, reducing waste of several metres of expensive inkjet paper. Particularly for short-run jobs, this waste-saving feature is a hugely attractive selling point.

**PC connection interface** -inevitably it became desirable for the Arduino to communicate with the outside world. Fortunately, the fantastically straightforward and standardised COM port driver allowed us to interface over USB with about three day of development effort. Having previously developed an SPI comms interface in the past, I can happily say that Arduino's higher level approach was more appealling as a developer. Once we had effective two-way communications between the printing machine and the PC, we were able to implement new features like batch counting and stopping automatically at the end of a job - another fantastic waste-saving feature.

**In-field modifications** - suppose a customer needed slightly different behaviour in their ink system, or a logic defect was discovered that needed correcting. With a PLC, that could have meant an expensive visit from a support engineer armed with a laptop and the PLC application software. But surely Arduino suffers the same problem? Not quite, because the Arduinos can be unplugged from the machine, it's now preferable to just post a new set of boards to the customer and allow them to do the upgrade themselves. In other words, deliver software updates via the postal system! The old Arduinos can be posted back or, better still, be inherited by a keen young mind, and feed the next generation!

**Low cost** - I often hear the opposite argument when discussing Arduino with the hobby and hacker scene. I agree that for integrating into a consumer product, the Arduino's off-the-shelf price is fairly expensive (although good luck designing and making a small batch yourself for cheaper...). However when integrated in a five-figure industrial printing machine, the cost comes close to zero, especially when considering the PLC alternative and the support benefits. If JF Machines were ever to mass-produce their machines, reducing the price of the Arduino would be fairly low on the list of priorities!

Of course, these benefits weren't completely without pain. Although I developed all the code for the first version, it has since become necessary (and desirable) for JF Machines to learn to do it themselves for when I'm not available. Fortunately it's been a pleasant experience as the fantastic little IDE takes away much of the pain of C and C++ development.

Furthermore, source code control is likely to become an issue, and this is not an area that JF Machines has any experience in. It's tempting to "over-fork" software to allow customer-specific mods, but - as with hardware - managing those separate code branches quickly becomes challenging. However, this isn't a new issue - it was just as relevant when developing PLC "programs". These are often in a proprietary, possibly binary format. The benefit of  using C in Arduino is that at least the language is standardised, non-proprietary, and well suited for source control.

![Five arduinos inside the ink cabinet](/img/five-arduinos-inside-the-ink-cabinet.jpg){: .img-responsive }

*5 Arduinos inside the ink cabinet*

**Verdict**

For JF Machines, Arduino was a great fit. Although it has required them to gain new software development and organisation skills, it has brought enormous benefits. In their application - high tech, low volume - the Arduino is a fantastically cheap and flexible solution. It has enabled them to create tangible new features as well as reducing their support cost and effort.

**Arduino, 1 nil!**


I'd like to hear your thoughts - why not give me a shout on <a title="Paul Furley on Twitter" href="https://twitter.com/paul_furley" target="_blank">Twitter</a> or <a title="Contact" href="http://paulfurley.com/contact/" target="_blank">drop me an email</a>?

**UPDATE:** Join the (extensive) discussion at [Reddit][2] and [Hack A Day][3] - many thanks for all the interest!


 [2]: http://redd.it/1hhk3f
 [3]: http://hackaday.com/2013/07/08/this-is-run-by-an-arduino/
