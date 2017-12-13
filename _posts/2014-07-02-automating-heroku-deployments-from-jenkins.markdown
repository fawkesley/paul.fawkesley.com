---
title: Automating our Heroku deployments from Jenkins
permalink: /automating-heroku-deployments-from-jenkins/
category: devops

---
*At Sea Level Research we deploy to Heroku staging then production from Jenkins, with automatic database backups & migrations. Read on to find out how.*

Last week we released an early version of an API that we're hosting with Heroku. We're an early-stage startup and this is a component of our first product. At this point in our startup life, Heroku is a great fit as we need to focus on features, not infrastructure. We are targeting corporate customers with a pretty niche product, so we aren't likely to suffer from massive overnight scaling issues.

## Automating Heroku

I love Heroku, but I always find the command line deployment stuff a bit fiddly. How do I turn on maintenance mode again? How do I backup the database before I run the migrations? And given that I'm fanatical about automation - especially when it comes to deployment - it made sense to tackle our process from day one. *If you don't believe in automating deployment you might get some amusement reading <a href="http://dougseven.com/2014/04/17/knightmare-a-devops-cautionary-tale/" target="_blank">Knightmare: a devops cautionary tale</a>...*

My wishlist of requirements went like this:

  * I want a point-and-click deployment to Staging or Production - this must encapsulate all knowledge about how the deploy works.
  * I want to automatically run database migrations.
  * For staging deployments, I want to run the migrations against an exact copy of the production database to check we're in sync.
  * For production deployments, I want to backup the database before I run migrations, in case they bork it up.
  * I want to put the app in and out of maintenance mode automatically.
  * I want to make sure I've got at least one web worker running.
  * I want this done from a Jenkins box with its own credentials.

## One simple shell script

It turns out this is reasonably straightforward using Heroku's command line client. In an afternoon I wrote up the following shell script which fulfills most of the above:

<a href="https://github.com/sealevelresearch/sea-level-api/blob/master/scripts/jenkins_deploy_to_heroku.sh" target="_blank">https://github.com/sealevelresearch/sea-level-api/blob/master/scripts/jenkins_deploy_to_heroku.sh</a>

The most interesting bit is probably the use of the **pgbackups **Heroku add-on. During a staging deployment, the script instructs the backups module to backup production, then get a URL to its backup. It **resets** the staging database - rather than just overwriting rows - to ensure the schemas exactly match, then restores the production backup into staging. This means we have confidence that the subsequent database migrations are running against the actual database.

## Configuring Jenkins

It turns out quite a large chunk of the work came about from configuring our Jenkins box to have the necessary tools, like the heroku command line client. For this we use the excellent <a href="http://www.ansible.com/home" target="_blank">Ansible</a>, and we've had to make a fair few lightweight modules now such as<a href="https://github.com/sealevelresearch/ansible-heroku-toolbelt" target="_blank"> ansible-heroku-toolbelt</a> as <a href="https://github.com/sealevelresearch/ansible-jenkins" target="_blank">ansible-jenkins</a>.

None of this is rocket science, but I do believe that taking the time to implement this clean, conservative & repeatable processes will be worth every penny six months down the line when I'm trying to push out a 2am bugfix for a major client...

*<a href="https://twitter.com/paul_furley" target="_blank">Paul</a> is CTO of <a href="http://sealevelresearch.com" target="_blank">Sea Level Research</a>, a startup helping shipping ports to optimize their logistics.*