---
date: "2013-07-16"
title: Painless merge conflicts in Git
permalink: /painless-merge-conflicts-in-git/
category: devops
---
Resolving merge conflicts in Git can be a pain - I always find I need to see the **common ancestor** to understand what's going on with the two conflicting versions.

<a title="Painless merge conflict resolution in git" href="http://blog.wuwon.id.au/2010/09/painless-merge-conflict-resolution-in.html" target="_blank">This excellent blog post</a> explains how to enable 3-way diff and why it matters. The short version:

`$ git config --global merge.conflictstyle diff3`

Do you have any helpful git tips? **Leave a comment below.**
