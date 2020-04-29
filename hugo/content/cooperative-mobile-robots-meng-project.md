---
title: Cooperative Mobile Robots, MEng project
layout: page
---
This was part of my MEng in Communications Engineering - more or less a digital specialism of Electronics - at the University of Durham.

A lot of sweat and tears went into this piece of work so I felt it worth publishing for all to see. Summary and highlights are below.

**[Full Report: Cooperative Mobile Robots - Paul M Furley][project-pdf]**

Although I did investigate using Arduinos for the robots, I opted in the end for  Luminary Micro LM3S1968 evaluation board as it housed a powerful ARM Coretex-M3 processor and integrated OLED screen. This is the very same architecture now used by the <a title="Arduino Due with ARM Coretex M3" href="http://arduino.cc/en/Main/ArduinoBoardDue" target="_blank">Arduino Due</a>, one for the wish list...

**Summary**

> This project set out to design a system of cooperative mobile robots which could work together to map unfamiliar terrain. This required a multi-disciplinary approach involving the areas of communication, precise mechanical control, electronic design, interpreting sensor output, software development and human interface design. For the purpose of this project, a simplified mapping environment was used which involved a flat maze with a uniform, regular layout. Two robots were built although the system was designed to support many more. The wider applications of the system
> were considered throughout the project such as reconnaissance and search and rescue. To this end, the system was designed to be scalable and extensible, making use of modern hardware and portable software.
>
> Having selected a suitable microprocessor board, ranging sensors and stepper motors, a PCB was designed to accommodate the power electronics and connect the microcontroller to the other components. The robot chassis was extended with additional aluminium parts which were designed to mount the sensors and PCBs. When the hardware design was complete, software was developed to interface with the motors, sensors and radiofrequency chip. Finally, a graphical software application was developed to serve as the coordinator and to illustrate the system to a human operator.
>
> The system was developed to a point where two robots were able to reliably map an area, displaying the results in real time to the operator. This could be expanded beyond the uniform maze environment for mapping truly unfamiliar terrain. It could also act as a robust testing system for algorithm research or for teaching purposes.

**Visual highlights**

![My mobile robot hardware design](/img/robot-white-background2.jpg)

A Luminary Micro evaluation board (ARM Coretex-M3) mounted above my PCB on top of a commercial robot chassis which I extended with sensor housings. Spot the 2.4GHz transceiver peeking out the back!


![Co-operating robots communications overview](/img/overview-of-communications.png)

Multiple robots communicated in a centralised architecture, with a map building up on the display in real-time.

![PCB 3D render topside](/img/PCB-3D-render-topside.jpg)

I developed this PCB to mount the transistors I used for driving the stepper motors as well as connecting in the four infrared distance sensors


![Screenshot of system running](/img/screenshot-system-running.png)

This was the output of the system during a mapping run by two robots.

If you are interested, I have all the files from the project including bill of materials, source code, SolidWorks chassis design / mechanical drawings, Eagle PCB designs, datasheets, pin-outs, the lot.

**[Get in touch here.][contact]**

[project-pdf]: /files/Cooperative-Mobile-Robots-Paul-M-Furley.pdf
[contact]: /contact/ "Contact"
