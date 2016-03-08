FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y ruby2.0 ruby2.0-dev make gcc nodejs

# Ubuntu `ruby` defaults to 1.9.1 :(
# See https://bugs.launchpad.net/ubuntu/+source/ruby2.0/+bug/1310292
# Rename original out of the way, so updates / reinstalls don't squash our hack fix
RUN dpkg-divert --add --rename --divert /usr/bin/ruby.divert /usr/bin/ruby
RUN dpkg-divert --add --rename --divert /usr/bin/gem.divert /usr/bin/gem

# Create an alternatives entry pointing ruby -> ruby2.0
RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 1
RUN update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.0 1

RUN gem install jekyll --no-rdoc --no-ri
RUN gem install jekyll-redirect-from
RUN gem install jekyll-feed
