---
title: "Building Software Users Love"
snappy_title: "Building Software Users Love"
is_highlighted: true
permalink: /building-software-users-love/
---

*This was originally posted on the [NHS.UK Alpha project][nhs-alpha] blog.*

I'm Paul, and I'm a developer on the NHS.UK Alpha project. I wanted to share some thoughts about different ways of delivering software, and why we're working in the way we are.

<!--more-->

## It's Hard Building for Users You Don't Understand

I have some experience working in organisations where software was written to a specification – a large document which supposedly captured everything there was to know about a problem.

A hypothetical project would go something like this:

- Business analyst works with the users' manager to understand the users' problems
- Business analyst writes lots of requirements documents detailing *exactly* what the software should do and how
- Development team receive requirements and make lots of interpretations where things aren't clear (they never are)
- Project is delivered, client's users see the system for the first time, start giving feedback about what's wrong
- Any changes must go through “change request” process – it's like a new piece of work.
- The interesting thing for me was the observation that **it's hard building software for users you don't understand.**

I think one of the problems with this type of delivery is that there's a bit of a Chinese whisper situation going on, where every re-telling of the user need distorts the truth:

1. users tell their boss about their problems, not mentioning the hacks and workarounds they currently do
2. their boss tells the business analyst, forgetting some of the detail
3. the business analyst writes it down, losing some nuance
4. the developers read the document and make their own interpretations.

To compound the problem, when software is delivered in one great lump – at the end of the project – it's too late for feedback from the real users.

## Build, Test, Iterate

I'll come right out and say it: **I don't think users ever like version 1!**

However good we are at capturing user's needs, I just think that users have to get their hands on the software before we *really* know what they need.

So an alternative approach, and the one we're practising at NHS.UK Alpha, is **Build, Test, Iterate**.

The principle is simple enough – you build something small, you try it out on your users, you see what they love and hate, and you do it again, quickly.

## Keep it Simple

With everything we build, we try to start simple. It's always tempting to throw in the kitchen sink, or think up every situation where a solution *wouldn't* work. The danger with that is that it's easy to end up never building anything.

If we have a very broad user base (which in health, we do), it's helpful to create “personas” – made up people who are based on user interviews, but are specific rather than general. Then we create a solution which works for one of them first, then expand the solution to other personas, if possible.

Personas help to eliminate disagreement about how people on the team think a solution should be. They allow the team to put aside our own opinions and build for the needs of the persona, which reduces our own bias.

## Keep it Cheap (Fake it)

Iterating fast is essential, because each round of testing produces a lot of feedback. At each stage, it's useful to ask the question, *“How could we fake a solution well enough to test it?”*

Using paper and pens is a very fast way of getting ideas out of our heads and in front of users. Although it has limitations – for example it's hard to show user-interface interactions on paper – it's much faster than writing code, and users are often perfectly able to pretend they are tapping on an tablet.

We're also faking it with our prototyping kit. We've built *just enough* backend so that it feels to a user like they're really booking an appointment, or searching for a GP. We've spent exactly no time making it “production ready” – because this is a prototype. We tested it early, so if they'd absolutely hated it, or had no need for it, we would have found out quickly so the cost of throwing it away is low.

## Developers: Get Involved

Being a developer isn't just about writing code.

Writing code is important, but writing the *right* code is better.

We don't like waste, and I think we can reduce it by being involved at all stages – from participating in user lab days, to scribbling with sharpies on paper, to implementing production systems.

Ultimately, when we understand the user, it's easier to build things they love. And that means happy faces all round :)

[nhs-alpha]: http://transformation.blog.nhs.uk/building-software-users-love
