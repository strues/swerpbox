# What is SwerpBox?

[![CircleCI](https://circleci.com/gh/strues/swerpbox.svg?style=svg)](https://circleci.com/gh/strues/swerpbox)


> SwerpBox, a seedbox and media center combined with the power of  🐳 Docker.

# Prerequisites

To run this application you need Docker Engine 1.10.0+ and Docker Compose with a version 1.6.0 or later.

If you don't have Docker installed and are running Ubuntu 16.04, you may use the setup script, `swerp-setup.sh`. It will install Docker and Docker Compose for you.

`bash swerp-setup.sh`


# Get Started

Clone this repository or upload the contents of the repository to your web server. Where you place the SwerpBox files is where all the fun happens. I recommend working out of your home directory.

Example: `/home/<USER>/swerpbox`

Create a copy of the environment variables file with `cp env_example .env` and fill in the information to match with your environment.

The variables PGID, PUID, PLEX_UID, and PLEX_GUID must be set to the ids of the user running SwerpBox. If you aren't sure what the values of your user account are, you can find them by typing `id $(whoami)` on your server.

The output will look like this:

```
uid=1000(swerp) gid=1000(swerp) groups=1000(swerp)
```

It is crucial to set PGID and PUID variables to the values matching the user running SwerpBox.

# Containers

## Alpine
[![](https://images.microbadger.com/badges/image/swerpbox/alpine-base.svg)](https://microbadger.com/images/swerpbox/alpine-base "SwerpBox Alpine")  [![](https://images.microbadger.com/badges/version/swerpbox/alpine-base.svg)](https://microbadger.com/images/swerpbox/alpine-base "SwerpBox Alpine")



## Ubuntu


## Frontend
[![](https://images.microbadger.com/badges/image/swerpbox/frontend.svg)](https://microbadger.com/images/swerpbox/frontend "SwerpBox Frontend") [![](https://images.microbadger.com/badges/version/swerpbox/frontend.svg)](https://microbadger.com/images/swerpbox/frontend "SwerpBox Frontend")


Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PUID`: User UID. Default: **1000**
 - `PGID`: User group id. Default: **1000**


## rTorrent/ruTorrent

[![](https://images.microbadger.com/badges/image/swerpbox/rutorrent.svg)](https://microbadger.com/images/swerpbox/rutorrent "SwerpBox ruTorrent") [![](https://images.microbadger.com/badges/version/swerpbox/rutorrent.svg)](https://microbadger.com/images/swerpbox/rutorrent "SwerpBox ruTorrent")


> ruTorrent and rTorrent with Autodl-Irssi running on Alpine Linux. Compiled with Media Info

Includes PHP7 and Nginx 1.10.5.

RuTorrent is accessible via http://YOUR.IP.ADDR.ESS/rutorrent/

Volumes:

- `./data:/data`: Location of saved files.
- `./logs:/logs`: Logs for rutorrent-nginx, php and rTorrent.
- `./config:/config`: Configs for php, rutorrent-nginx, rTorrent, irssi, and autodl.

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PUID`: User UID. Default: **1000**
 - `PGID`: User group id. Default: **1000**

## Deluge
[![](https://images.microbadger.com/badges/image/swerpbox/deluge.svg)](https://microbadger.com/images/swerpbox/deluge "SwerpBox Deluge") [![](https://images.microbadger.com/badges/version/swerpbox/deluge.svg)](https://microbadger.com/images/swerpbox/deluge "SwerpBox Deluge")

> This container runs the Deluge BitTorrent daemon and the web ui. To learn more, visit the [Deluge website](http://deluge-torrent.org).

Deluge is accessible via http://YOUR.IP.ADDR.ESS/deluge

Available variables:

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

## Plex

Uses the official Plex Docker image. Checkout the readme [here](https://github.com/plexinc/pms-docker)

Plex is accessible via http://YOUR.IP.ADDR.ESS:3400/web

The default library location is `./media`

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PLEX_CLAIM`: Plex claim token. Get it from: **https://plex.tv/claim**
 - `ADVERTISE_IP`: Server IP address for Plex. Default: **http://127.0.0.1:32400**
 - `PLEX_UID`: User UID. Default: **1000**
 - `PLEX_GID`: User group id. Default: **1000**
 - `CHANGE_CONFIG_DIR_OWNERSHIP`: Change directory ownership. Default: **false**


## Filebot

Available variables:

  - `OUTPUT_FOLDER`: Directory Filebot outputs to. Default: **/media**
  - `INPUT_FOLDER`: Directory Filebot reads from. Default: **/data/complete**
  - `ACTION`: What should Filebot do? Default: **hardlink**
  - `MUSIC`: Do you want Filebot to handle music? Default: **n**
  - `PUID`: User UID. Default: **1000**
  - `PGID`: User group id. Default: **1000**
  - `TZ`: Your timezone. Default: **America/Denver**


## SickRage

SickRage is accessible via http://YOUR.IP.ADDR.ESS:8081

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PUID`: User UID. Default: **1000**
 - `PGID`: User group id. Default: **1000**

# Advanced Configuration

> Want to run your SwerpBox with valid SSL certificates and reverse proxying to subdomains? Yeah... me too.

Here's how we can make it happen:

**Step 1**
Go to where your DNS is hosted. Usually this is your domain registrar (where you bought it from). Create CNAME records
for the services, which you want to run from subdomains (rutorrent, plex, deluge, sickrage, etc...)

**Step 2**
After the DNS propogates we need to generate the LetsEncrypt certificates. Make sure the DNS has fully propogated or else
the validation will fail.

On your webserver, go to the root of your SwerpBox. In this case the root is `/home/swerp/swerpbox`.

Run the following command to generate certificates:

```
docker run --rm \
    -p 80:80 \
    -p 443:443 \
    --name letsencrypt \
    -v /home/swerp/swerpbox/srv/nginx/certs:/etc/letsencrypt \
    -e "LETSENCRYPT_EMAIL="email@email.com" \
    -e "LETSENCRYPT_DOMAIN1=yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN2=www.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN3=rutorrent.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN4=deluge.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN5=plex.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN5=plexpy.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN5=sickrage.yourdomain.com" \
    blacklabelops/letsencrypt install
```

Replace the `-e "LETSENCRYPT_EMAIL="email@email.com"` with your email address and all the **yourdomain.com** with your actual
domain name.

The certificates save to `/home/swerp/swerpbox/srv/nginx/certs` and are mounted inside the frontend container
under `/etc/nginx/certs/archive/LETSENCRYPT_DOMAIN1/*.pem`.

**Step 3**

In the directory `srv/nginx/vhost.d` you'll want to modify the example configurations for each subdomain.

