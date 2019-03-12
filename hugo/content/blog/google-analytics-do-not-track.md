---
date: "2018-04-11"
title: "Google Analytics with Do Not Track"
permalink: /google-analytics-do-not-track/
category: security,devops
---

*Respect your users' choice for privacy &mdash; disable Google Analytics for people using Do Not Track.*

<!--more-->

[Do Not Track](https://allaboutdnt.com/) is an HTTP header which indicates a person's preference to opt out of tracking. Most browsers require the person to explicitly turn on this setting. You can interpret it as a clear request to avoid tracking.

It's simple to respect your visitors' preference for privacy. Just put any analytics tracking code inside this `if` statement:

<script src="https://gist.github.com/paulfurley/bb900465c21b8570d8763af9a07fcfc7.js"></script>

This way, the analytics script won't even be downloaded from Google's servers. This improves your users' privacy and slightly speeds up the page load.

Do it now!
