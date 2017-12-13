---
title: 'Chilli Cam: Stop Motion Video using old Netbook'
permalink: /chilli-plant-stop-motion-video-linux/
category: sideprojects
---
I love hot food so a [grow-your-own chilli plant][1] kit was a great present to receive last Christmas.

![chilli plant kit I used to make a stop-motion video](/img/chilli-plant-kit.jpg){: .img-responsive }
*Chilli plant kit, courtesy of Kew Gardens.*

I soon realised, however, that growing plants is far too slow to capture my attention - what I needed was a tech project!

I'd been toying with the idea of making stop-motion videos for a while but had never found a suitable subject. My new chilli plants-to-be felt to be the perfect A-listers for my aspiring blockbuster creation.

What I needed next was a camera and a Linux machine to automate taking the pictures. This seemed like the perfect application for my now obsolete Netbook - the once much-loved Samsung N110.

![samsung 110 netbook](/img/samsung-n110-netbook.jpg){: .img-responsive }

*Image courtesy of laptopmag.com*

The netbook is equipped with a basic 1.3MP webcam - I won't be expecting any super quality shots - but a great start. I installed the lightweight <a title="Lubuntu operating system" href="http://www.lubuntu.net/" target="_blank">Lubuntu</a> operating system and put together a couple of scripts.

The first script fires off the wonderfully simple <a title="fswebcam" href="http://www.firestorm.cx/fswebcam/" target="_blank">fswebcam</a> every minute. That tool has some great features, such as the ability to take several shots over a period and average them into one. I noticed a significant quality increase from taking 10 shots rather than one. I expect one could also use this feature to reduce the impact of sudden changes in light (due to clouds moving across the sun and so on). The other great feature is the ability to crop the image at a certain region. The positioning of the camera was such that it could see quite a lot of our office on the right of the plants - it was easy to crop these out of the picture.

![fswebcam snapshot of chillicam](/img/chilli-cam-fswebcam.jpg){: .img-responsive }

*Snapshot taken using fswebcam*

The second script runs at midnight every day and uses [mencoder](https://en.wikipedia.org/wiki/MEncoder) to create a motion jpeg video from the captured frames. I had to tweak the parameters to get a good balance of size and quality but the end result looks good.

Finally, for convenience, I copy the video over to my Dropbox directory so that it automatically synchronises to my main machines. This isn't particularly bandwidth-efficient but it's preferable to having to SSH into the netbook and copy the video across. This allowed me to see just how much growth had occurred over the previous day (more than I expected) which was frankly a lot more exciting than watching the plants in realtime.

Finally I manually cut out boring night-time frames and posted on Vimeo. Admittedly it's not the most thrilling spectacle - I think a bit of speed up and some trusty Philip Glass might do the trick, though...



All the code is available at [github.com/paulfurley/chillicam](http://github.com/paulfurley/chillicam)

 [1]: http://shop.kew.org/kew-chilli-garden.html# "Kew Chilli Garden"
