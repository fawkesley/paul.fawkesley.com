---
title: "Don't Like It? Block it! Internet filtering in libraries"
permalink: /dont-like-it-block-it-internet-filtering-in-libraries/
category: security, startups, sideprojects, publicspeaking, python, arduinoraspberrypi, gpgforhumans, devops
---

![Liverpool Express: payday loans companies blocked](/img/liverpool-express-payday-loans-companies.png){: .img-responsive }

Here's a long-overdue write up of an interesting thing I stumbled across back in 2013.

It started with a tweet from Liverpool City Council (since deleted) announcing they would be blocking the websites of payday loans companies in the libraries and other city buildings.

I hadn't considered that councils would block specific websites in their libraries.

To me this immediately raised concerns. While I personally feel payday loans companies are vile, they are legal businesses. I wanted to know more.
There was an [article in Liverpool Express][liverpool-express-article] (since deleted but I found an archive copy) with a few questions and answers to a councillor.

<blockquote>
But payday loan companies are lawful –why should people be prevented from seeing their websites?
</blockquote>

<blockquote>
"They may be legal – although their activities are to be investigated – but I would argue that the way they operate is certainly not ethical and that is why their sites should be blocked."
</blockquote>

Right, so the council will block what it considers to be "unethical". I wonder what that means?

Who gets to decide? What else is blocked?

*To be clear, I believe the council was acting in good faith. I just don't think they were taking the right approach.*

## Enter Freedom of Information

Having been hanging around with [mySociety][mysociety] folks for a while, I'd learned about Freedom of Information, and I used their excellent service to make my very first [freedom of information request][first-foi].

![Get answers from the government and public sector](/img/what-do-they-know.png){: .img-responsive }

I wanted to know:

- what's blocked?
- how is it blocked technically?
- who chooses what's blocked?

After some back and forth, a very helpful man in the council provided me some of what I'd asked for.

## There were 30 blocked categories

The blocked categories were:

- Alcohol
- Anonymizers
- Anonymizing Utilities
- Browser Exploits
- Discrimination
- Drugs
- Extreme
- Game / Cartoon Violence
- Gruesome Content
- Historical Revisionism
- Illegal UK
- Malicious Downloads
- Malicious Sites
- Nudity
- P2P / File Sharing
- Phishing
- Pornography
- Potential Criminal Activities
- Potential Hacking / Computer Crime
- Potential Illegal Software
- Profanity
- PUPs
- Residential IP Addresses
- School Cheating Info
- Sexual Materials
- Spam URLs
- Spyware / Adware / Keyloggers
- Tobacco
- Violence
- Weapons

That's quite a list!

Straight away looking at this list I'm thinking of problems:

- Alcohol, Drugs: Does this mean websites *selling* alcohol and drugs? How about information about them? How about support groups for alcohol and drug abuse?
- Nudity: Wow, that's broad. Does that include websites about anatomy, then?
- Violence: What about violence? Promoting it? Condemning it? Reporting on it? I see a lot of violence in the news, is that allowed?
- Illegal UK: Whaaaat? Does that means sites that *are* illegal in the UK? (I'm not even sure what this would cover), or sites that are *about* illegal things in the UK - like drink driving, for example?
- Residential IP Addresses: Blocking these is just crappy: I run a personal website off my home internet connection, what's the problem with that? This undermines a core principle of the neutrality of the internet.

A blocked category relies on someone, or something classifying that site. This is typically outsourced to the company that provides the filtering software, who would typically automate most of the classification process. In other words, a computer makes most of the decisions.

It's concerning for me how much power we give to these third parties and their proprietary computer systems to control what information we're allowed to look at.

## There were 1,187 blocked URLs.

Most of these were pretty boring - there were a lot of payday loans companies, as promised.

I've picked out a few that stood out for me:

- [brusselsbedandbreakfast.be](http://brusselsbedandbreakfast.be/)
- [gaydar.co.uk](http://gaydar.co.uk)
- [liverpoolungagged.com](http://liverpoolungagged.blogspot.co.uk/)
- [merseywindows.co.uk](http://merseywindows.co.uk/)
- [wirralmetals.com](http://www.wirralmetals.com/)
- [profchucklebuttychronic.blogspot.co.uk](http://profchucklebuttychronic.blogspot.co.uk/)

*Bear in mind that I don't know when or why these sites were blocked: the council did not provide that information.*

You can explore the full list in the [spreadsheet][2013-spreadsheet] provided by the council.

## One Year Later

The first request was of limited value because I couldn't date any of the block requests, and I couldn't get any of the reasoning behind the blocks. They could have been decades old, which doesn't give much clue about the context of why they were blocked.

I figured that if I placed [another request][second-foi] in a year I would at least be able to see what sites had been added or removed in that time.

## 30 blocked categories, down with Consumer Protection!

This time there were 30 blocked categories, but they'd changed a little.

Unblocked since 2013:

- Alcohol
- Violence

Blocked since 2013:

- Consumer Protection
- Parked Domain

I can't imagine why Consumer Protection would be blocked - weird.

## 538 blocked websites

Encouragingly, this time the number of blocked websites had halved.

All of the sites I picked out above were now unblocked.

I've picked out a few new blocks since 2014 that I thought were interesting:

- [awe.co.uk](http://awe.co.uk) - this is the MOD [Atomic Weapons Establishment][awe-wikipedia]
- [defenseindustrydaily.com](defenseindustrydaily.com)
- facebook.com
- google.com/images
- www.youtube.com

Again, the full list is in the [2014 spreadsheet][2014-spreadsheet] provided by the council.

It's pretty weird for a local council to be blocking the website of a department of the Ministry of Defence.

Hopefully this post highlights some of the moral questions raised when censoring the internet.

[Contact me on twitter.][paul-twitter]


[awe-wikipedia]: https://en.wikipedia.org/wiki/Atomic_Weapons_Establishment
[liverpool-express-article]: http://web.archive.org/web/20130803194645/http://www.liverpoolexpress.co.uk/2013/08/01/payday-loan-websites-blocked/
[mysociety]: https://www.mysociety.org/
[first-foi]: https://www.whatdotheyknow.com/request/filtering_system_and_blocked_web
[2013-spreadsheet]: https://www.whatdotheyknow.com/request/171481/response/422836/attach/2/269825%20Furley%20att1%20220813.xls
[second-foi]: https://www.whatdotheyknow.com/request/categories_and_specific_websites?unfold=1
[2014-spreadsheet]: https://www.whatdotheyknow.com/request/232900/response/586666/attach/2/Copy%20of%20URLs.xlsx


[paul-twitter]: https://twitter.com/fawkesley
