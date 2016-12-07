---
title: "Taking Back My Data, Part 1: Move from Dropbox to Nextcloud"
permalink: /taking-back-my-data-move-from-dropbox-to-nextcloud/
category: security
---

*This post documents how I moved from Dropbox to self-hosting a "private cloud"
using Nextcloud on a Raspberry Pi in my home.*

![Nextcloud home screen](/img/raspberry-pi-nextcloud-screenshot.png){: .img-responsive }

[See all updates and edits.][page-updates]

## Objective: Kick Dropbox

Today I achieved step one of my master plan to take back ownership of my data. In this blog post I'll describe how I switched from using Dropbox to my own "cloud", physically located inside my home.

Right now, I've taken back my *files*, for example photos, scanned documents, money stuff and business stuff.

Next I want to take back:

- calendar - I've got over ten years of calendar stored in Google and it freaks me out
- contacts - Again, Google knows everything.
- email - Much harder, but the holy grail. Worth it? Not sure.

This blog post is both to document how I did it and make it easier for the next person.

The software and hardware setup looks like this:

- Raspberry Pi (the 4-core one with 1GB memory)
- [Rasbian Lite][raspbian-lite] (based on Debian jessie)
- [Nextcloud][nextcloud] 10 (a fork of Owncloud)
- Nginx
- PostgreSQL

## Install and Harden Raspberry Pi

I downloaded [Raspbian Lite][raspbian-lite] 2016-11-25 and transferred it onto an SD card with the `dd` command.

I connected the Pi to my router, powered it up and found the IP address in the router. I logged in with SSH and
started configuring it.

```
ssh pi@192.168.0.191
```

First I set the hostname to `pi-loft-2` and rebooted.

```
sudo sed -i 's/raspberrypi/pi-loft-2/g' /etc/hostname /etc/hosts
sudo reboot
```

Next I downloaded a script I often use called "Ubuntu Trusty First Five Minutes". This is based on a [blog post][first-five-minutes] and it carries out some basic hardening.

```
wget 'https://github.com/paulfurley/ubuntu-trusty-first-five-minutes/archive/master.zip'

unzip master.zip && cd ubuntu-trusty-first-five-minutes-master/

# EDIT AND UNDERSTAND BOOTSTAP.SH BEFORE YOU RUN IT

./ubuntu-trusty-first-five-minutes-master/bootstrap.sh
```

## Install ZeroTier One

[ZeroTier One][zerotier-one] is a massively useful decentralized VPN service I use for connecting my devices and getting around NAT and so on. I installed that, joined my private network from the command line, then granted access to the device from the ZeroTier One web interface.

```
curl -s https://install.zerotier.com/ | bash  # this is really bad practice, btw

sudo zerotier-cli join <my network id>
```

## Set up hosts and SSH config

For convenience, I added these lines to my `~/.ssh/config`:

```
# ~/.ssh/config

Host pi-loft-2
    User paulfurley
```

And to `/etc/hosts` (note that this is a ZeroTier One "local" address, not a real one):

```
# /etc/hosts
21.136.137.224  pi-loft-2
```

With the power of ZeroTier One, I can now do `ssh pi-loft-2` from anywhere in the world!

## Configure Encrypted External Hard Drive

I use [cryptsetup][cryptsetup] to mount an encrypted drive at `/media/externalhd`.

```
sudo apt-get install cryptsetup
```

Note: I aready had an external hard drive formateed as an encrypted LUKS volume. I'm going to skip over how to create the disk because it's destructive, and can't remember the exact commands. If you want an encrypted disk, have a read about the `cryptsetup luksFormat` command, then come back here.

I use a [mount script][mount-script] to help me remember how to do this. There are two options: you can either store the key as a file on the Raspberry Pi (insecure, but protects against casual theft of the hard drive), or you'll have to enter it each time the Pi boots.

## Configure cloud.paulfurley.com in DNS

I went over to my domain registrar, namecheap.com, and created an A record for `cloud.paulfurley.com` to point at my (static) home IP address.

Unlike most UK ISPs, [Andrews & Arnold][andrews-and-arnold] give you a static IP address by default. Don't forget to ask your ISP to set this up for you.

## Configure port forwarding on home router

I logged into my home router and allocated a static IP `192.168.0.191` to the new Raspberry Pi.

I configured port forwarding for port 80 and 443 (HTTP and HTTPS) through to that IP address.

Now anyone connecting to `http[s]://cloud.paulfurley.com` will hit my home router, which will pass them straight through to the Raspberry Pi, `pi-loft-2`.

## Install Nginx

I installed the [Nginx 1.6.2][nginx-1.6.2] from the normal Debian jessie respository:

```
sudo apt-get install nginx
```

and disabled the default configuration:

```
sudo rm /etc/nginx/sites-enabled/default
```

## Get an SSL/TLS Certificate with Let's Encrypt

I needed a TLS certificate for `cloud.paulfurley.com` to secure connections to NextCloud. I used Let's Encrypt with the client called `certbot`, and a minimal default Nginx configuration to get things rolling.

Add jessie-backports and install certbot:

```
echo "deb http://ftp.debian.org/debian jessie-backports main" |sudo tee /etc/apt/sources.list.d/jessie-backports.list
sudo apt-get update
sudo apt-get install -t jessie-backports -y certbot
```

I enabled a [minimal Nginx configuration][nginx-letsencrypt] that works with the certbot webroot strategy:

```
wget -O /etc/nginx/sites-available/letsencrypt-bootstrap https://github.com/paulfurley/nextcloud-config-files/raw/master/etc/nginx/sites-available/letsencrypt-bootstrap
sudo ln -s /etc/nginx/sites-available/letsencrypt-bootstrap /etc/nginx/sites-enabled/letsencrypt-bootstrap
sudo service nginx reload
```

I ran `certbot` in dry-run mode:

```
sudo mkdir -p /etc/letsencrypt/fake-webroot
sudo certbot --dry-run certonly --webroot -w /etc/letsencrypt/fake-webroot -d cloud.paulfurley.com
```

... that worked, so I ran it again without `--dry-run` and got a new certificate located at:

```
/etc/letsencrypt/live/cloud.paulfurley.com/*.pem
```

Then I disabled the Nginx configuration (we'll handle renewals later):

```
sudo rm /etc/nginx/sites-enabled/letsencrypt-bootstrap
sudo service nginx reload
```


## Install and Configure PHP 7.0 and modules

I wanted to use the modern PHP 7.0, but jessie only had version 5.6.

I added the `stretch` distribution to `apt`:

```
echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" | sudo tee > /etc/apt/sources.list.d/stretch.list
```

... but in order to prevent everything upgrading to (less stable) stretch packages, I pinned everything to jessie by adding this to `/etc/apt/preferences.d/pin-to-jessie.pref`:

```
Package: *
Pin: release n=jessie
Pin-Priority: 600
```

Then updated the cache:

```
sudo apt-get update
```

I installed the [PHP prerequisites][php-prerequisites] from the installation manual (note the use of `-t stretch`)

```
sudo apt-get install -t stretch php7.0-cli php7.0-gd php7.0-xml php7.0-mbstring php7.0-zip php7.0-pgsql php7.0-curl php7.0-bz2 php7.0-intl php7.0-mcrypt php7.0-fpm
```

Note: there were some other, optional(?) packages that I didn't install.

### Configure PHP-FPM environment variables

I don't know why this is necessary, but the manual said to do it.

Uncomment the environment variables lines in `/etc/php/7.0/fpm/pool.d/www.conf`, as per the [Nextcloud docs][nextcloud-php-env-docs]

```
env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp
```

## Install and Configure PostgreSQL Database

I installed PostgreSQL 9.6:

```
sudo apt-get install -t jessie postgresql-9.6
```

And created a database and user:

```
sudo su - postgres
createdb nextcloud

PASSWORD=$(openssl rand -base64 15)
echo "PASSWORD: $PASSWORD"

echo "CREATE USER nextcloud WITH PASSWORD '${PASSWORD}';" | psql nextcloud
echo "GRANT ALL PRIVILEGES ON DATABASE \"nextcloud\" TO nextcloud;" | psql nextcloud
```

**Keep a note of this database password!** You'll need to configure Nextcloud with it.


## Download and Verify NextCloud

I downloaded the latest Nextcloud server, version 10.0.1:

```
cd /tmps
wget 'https://download.nextcloud.com/server/releases/nextcloud-10.0.1.zip'
```

### Verify its PGP signature

I got the signing PGP key and the checksums file and verified the install:

```
wget https://download.nextcloud.com/server/releases/nextcloud-10.0.1.zip.asc
wget https://nextcloud.com/nextcloud.asc
gpg --import nextcloud.asc
gpg --verify nextcloud-10.0.1.zip.asc nextcloud-10.0.1.zip
```

I saw:

```
gpg: Good signature from "Nextcloud Security <security@nextcloud.com>"
```

*(And also a warning that the key is not certified with a trusted signature. That means I haven't independently verified that the signing key I downloaded, `nextcloud.asc`, is actually Nextcloud's key - it could have been replaced with a bad one. As a half-measure I Googled the key fingerprint [2880 6A87 8AE4 23A2 8372  792E D758 99B9 A724 937A][google-fingerprint] and saw it listed on many sites, giving it at least some credibility.)*

## Install NextCloud into Nginx webroot

```
cd /tmp
unzip nextcloud-10.0.1.zip
sudo mv /tmp/nextcloud /var/www/html
sudo chown -R root /var/www/html/nextcloud
sudo chgrp -R www-data /var/www/html/nextcloud
```

I installed and enabled a [nextcloud Nginx configuration file][nginx-nextcloud]:

```
wget -O /etc/nginx/sites-available/nextcloud https://github.com/paulfurley/nextcloud-config-files/raw/master/etc/nginx/sites-available/nextcloud
sudo ln -s /etc/nginx/sites-available/nextcloud /etc/nginx/sites-enabled/nextcloud
sudo service nginx restart
sudo service php7.0-fpm restart
```


## Configure Nextcloud

I added `cloud.paulfurley.com` to the `trusted_domains` setting in `/var/www/nextcloud/config/config.php`:

```
  array (
    0 => '192.168.0.191',
    1 => 'cloud.paulfurley.com',
  ),
```

And fixed `overwrite.cli.url`:

```
  'overwrite.cli.url' => 'https://cloud.paulfurley.com/nextcloud',
```

I gave Nextcloud (or specifically, the `www-data` user) permission to write its own configuration:

```
sudo chmod -R 750 /var/www/nextcloud/{config,apps}
```

*Note: I initially didn't allow this, but ran into problems where the server would return HTTP 503 for WebDAV requests. Making the config writeable fixed this. Hmm.*

I made the Nextcloud data directory on the external hard drive:

```
sudo mkdir /media/externalhd/nextcloud
sudo chown www-data /media/externalhd/nextcloud
```

### Use Nextcloud's own configuration screen

I visited `https:/cloud.paulfurley.com/nextcloud/` and created an admin user. I entered the PostgreSQL database name, user and password, and was away.

I then used Nextcloud to create a normal (non-admin) user. I will keep the admin user for special occasions.


## Install Nextcloud iPhone App

I downloaded the iPhone Nextcloud app and logged in using the URL `https://cloud.paulfurley.com/nextcloud` and the username and password of my new, normal user.


## Install Scanner Pro iPhone App

I configured a new "cloud" service of the type WebDAV in Scanner Pro. I used the following URL with the username and password of my new user:

```
https://cloud.paulfurley.com/nextcloud/remote.php/dav/paul/
```


## Future Improvements

That was a good minimum viable config, but I've still got some things that need
improving:

- Try and move authentication to Nginx (before hitting Nextcloud's PHP) if possible and investigate TLS client certificates.
- Configure automatic certificate renewal with Let's Encrypt.
- Improve SSL score (currently B due to weak Diffie Hillman parameters, see [SSL Labs analysis][ssl-labs-results])
- Set up log monitoring & intrusion detection. Configure fail2ban to understand Nextcloud authentication failures.
- Move postgresql database from the SD card to the external hard drive.
- Automatically backup configuration.
- Automatically backup *everything* (incrementally) to another, offsite server.

![Raspberry Pi in my loft](/img/raspberry-pi-nextcloud-loft.jpg){: .img-responsive }

[Thoughts?][paul-twitter]

[nginx]: http://nginx.org
[nextcloud-php-env-docs]: https://docs.nextcloud.com/server/9/admin_manual/installation/source_installation.html#php-fpm-configuration-notes
[raspbian-lite]: https://www.raspberrypi.org/downloads/raspbian/
[first-five-minutes]: https://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers
[cryptsetup]: https://linux.die.net/man/8/cryptsetup
[mount-script]: https://github.com/paulfurley/nextcloud-config-files/blob/master/root/mount.sh
[zerotier-one]: https://zerotier.com
[nginx-1.6.2]: http://nginx.org/en/CHANGES-1.6
[php7-raspberry-pi]: https://getgrav.org/blog/raspberrypi-nginx-php7-dev
[php-prerequisites]: https://docs.nextcloud.com/server/9/admin_manual/installation/source_installation.html#prerequisites-label
[nginx-letsencrypt]: https://github.com/paulfurley/nextcloud-config-files/blob/master/etc/nginx/sites-available/letsencrypt-bootstrap
[nginx-nextcloud]: https://github.com/paulfurley/nextcloud-config-files/blob/master/etc/nginx/sites-available/nextcloud
[nextcloud]: https://nextcloud.com
[andrews-and-arnold]: http://aaisp.net
[google-fingerprint]: https://www.google.co.uk/?gfe_rd=cr&ei=0TpHWPHcHqeg8wewparoBg&gws_rd=ssl#q=2880+6A87+8AE4+23A2+8372++792E+D758+99B9+A724+937A
[page-updates]: https://github.com/paulfurley/www.paulfurley.com/commits/master/_posts/2016-12-01-my-move-from-dropbox-to-nextcloud.markdown
[ssl-labs-results]: https://www.ssllabs.com/ssltest/analyze.html?d=cloud.paulfurley.com
[paul-twitter]: https://twitter.com/paul_furley
