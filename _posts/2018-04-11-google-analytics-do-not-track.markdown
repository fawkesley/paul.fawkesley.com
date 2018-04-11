---
title: "Google Analytics with Do Not Track"
permalink: /google-analytics-do-not-track/
category: security,devops
---

*Respect your users' choice for privacy &mdash; disable Google Analytics for people using Do Not Track.*

<!--more-->

[Do Not Track](https://allaboutdnt.com/) is an HTTP header which indicates a person's preference to opt out of tracking. Most browsers require the person to explicitly turn on this setting. You can interpret it as a clear request to avoid tracking.

If you value your users' choice for privacy, you should respect these requests. Don't load Google Analytics for these people.

It's incredibly simple to disable Google Analytics for people with Do Not Track. Put the tracking code inside `if(navigator.doNotTrack != "1") {`:

<script src="https://gist.github.com/paulfurley/bb900465c21b8570d8763af9a07fcfc7.js"></script>

This way, the analytics script won't even be downloaded from Google's servers. This improves your users' privacy and slightly speeds up the page load.

Do it now!
