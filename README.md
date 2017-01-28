# What is SwerpBox?

[![CircleCI](https://circleci.com/gh/strues/swerpbox.svg?style=svg)](https://circleci.com/gh/strues/swerpbox)


> SwerpBox, a seedbox and media center combined with the power of  🐳 Docker.

## Prerequisites

To run this application you need Docker Engine 1.10.0+ and Docker Compose with a version 1.6.0 or later.

If you don't have Docker installed and are running Ubuntu or Debian, you may use the setup script, `setup-docker.sh`. It will install Docker and Docker Compose for you.

`bash setup-docker.sh`


## Get Started

Clone this repository or upload the contents of the repository to your web server. Where you place the SwerpBox files is where all the fun happens. I recommend working out of your home directory.

Example: `/home/<USER>/swerpbox`

Create a copy of the environment variables file with `cp env_example .env` and fill in the information to match with your environment.

The variables PGID, PUID, PLEX_UID, and PLEX_GUID must be set to the ids of the user running SwerpBox. If you aren't sure what the values of your user account are, you can find them by typing `id $(whoami)` on your server.

The output will look like this:

```
uid=1000(swerp) gid=1000(swerp) groups=1000(swerp)
```

It is crucial to set PGID and PUID variables to the values matching the user running SwerpBox.

**Note:** The file `buildall.sh` is meant for CI services. To start everything just run, `make start or docker-compose up -d`

The `init.sh` script will create a user and group named swerp, set the GID and UID, and create the `.env` file for you.

Running `make help` lists all commands available to you.

### Structure

```bash
 docker/
    ├── base
    ├── deluge
    ├── filebot
    ├── frontend
    ├── plexpy
    ├── rutorrent
    └── sonarr
 data/
    ├── complete
    ├── downloading
    ├── dwatch
    └── rtwatch
 media/
    ├── Movies
    └── TV Shows
 srv/
    ├── nginx
    └── public
 config/
    ├── deluge
    ├── frontend
    ├── php
    ├── plex
    ├── plexpy
    ├── resilio
    ├── rtorrent
    ├── rutorrent
    ├── rutorrent-nginx
    ├── sickrage
    ├── sonarr
    └── tmp
 logs/
    ├── deluge
    ├── filebot
    ├── frontend
    ├── rtorrent
    ├── rutorrent
    └── rutorrent-nginx
 docker-compose.yml
```

## Containers

### Base Images

#### Alpine

[![](https://images.microbadger.com/badges/image/swerpbox/alpine-base.svg)](https://microbadger.com/images/swerpbox/alpine-base "SwerpBox Alpine")  [![](https://images.microbadger.com/badges/version/swerpbox/alpine-base.svg)](https://microbadger.com/images/swerpbox/alpine-base "SwerpBox Alpine")

#### Ubuntu

[![](https://images.microbadger.com/badges/image/swerpbox/ubuntu-base.svg)](https://microbadger.com/images/swerpbox/ubuntu-base "SwerpBox Ubuntu")  [![](https://images.microbadger.com/badges/version/swerpbox/ubuntu-base.svg)](https://microbadger.com/images/swerpbox/ubuntu-base "SwerpBox Ubuntu")


### Frontend

[![](https://images.microbadger.com/badges/image/swerpbox/frontend.svg)](https://microbadger.com/images/swerpbox/frontend "SwerpBox Frontend") [![](https://images.microbadger.com/badges/version/swerpbox/frontend.svg)](https://microbadger.com/images/swerpbox/frontend "SwerpBox Frontend")

> Nginx 1.11.8 compiled from source with Brotli compression and HTTP/2 support.

The nginx default host configuration is setup for you. Located in `srv/nginx/vhost.d/site.conf`. See the advanced configuration below for specifics on
how to setup reverse proxies for enabled services.

**Available variables:**

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

**Volumes:**

- `./srv/nginx:/etc/nginx`: Nginx configuration.
- `./srv/public:/var/www/public`: Web root for the frontend.


### rTorrent/ruTorrent

[![](https://images.microbadger.com/badges/image/swerpbox/rutorrent.svg)](https://microbadger.com/images/swerpbox/rutorrent "SwerpBox ruTorrent") [![](https://images.microbadger.com/badges/version/swerpbox/rutorrent.svg)](https://microbadger.com/images/swerpbox/rutorrent "SwerpBox ruTorrent")


> ruTorrent and rTorrent with Autodl-Irssi running on Alpine Linux. Compiled with Media Info

Includes PHP7 and Nginx 1.10.5.

RuTorrent is accessible via http://YOUR.IP.ADDR.ESS/rutorrent/

**Available variables:**

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

**Volumes:**

- `./data:/data`: Location of saved files.
- `./logs:/logs`: Logs for rutorrent-nginx, php and rTorrent.
- `./config:/config`: Configs for php, rutorrent-nginx, rTorrent, irssi, and autodl.


### Deluge

[![](https://images.microbadger.com/badges/image/swerpbox/deluge.svg)](https://microbadger.com/images/swerpbox/deluge "SwerpBox Deluge") [![](https://images.microbadger.com/badges/version/swerpbox/deluge.svg)](https://microbadger.com/images/swerpbox/deluge "SwerpBox Deluge")

> This container runs the Deluge BitTorrent daemon and the web ui. To learn more, visit the [Deluge website](http://deluge-torrent.org).

Deluge is accessible via http://YOUR.IP.ADDR.ESS/deluge

**Available variables:**

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

### Plex

Uses the official Plex Docker image. Checkout the readme [here](https://github.com/plexinc/pms-docker)

Plex is accessible via http://YOUR.IP.ADDR.ESS:3400/web

The default library location is `./media`

**Available variables:**

- `TZ`: Your timezone. Default: **America/Denver**
- `PLEX_CLAIM`: Plex claim token. Get it from: **https://plex.tv/claim**
- `ADVERTISE_IP`: Server IP address for Plex. Default: **http://127.0.0.1:32400**
- `PLEX_UID`: User UID. Default: **1000**
- `PLEX_GID`: User group id. Default: **1000**
- `CHANGE_CONFIG_DIR_OWNERSHIP`: Change directory ownership. Default: **false**


### Sonarr

> The Sonarr container runs on Ubuntu 16.04 via Mono

Sonarr is accessible via http://YOUR.IP.ADDR.ESS:8989

**Available variables:**

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

**Volumes:**

- `./config/sonarr:/config`: Where the config files are stored.
- `./data:/data`: Entire directory of all files. Used to mount the complete folder.
- `./data/downloading:/downloads`: Where downloading torrents are located
- `./media/TV Shows:/tv`: Location of media directory, where Plex reads from. Sonarr hardlinks complete files here.

Setting up Sonarr to automatically use rTorrent to download files and automatically
hardlink them to the organized media folder is easy.

1.Visit the Sonarr web interface.
2.Go to `Download Client` and click add.
3.Choose rTorrent and enter the settings shown in the screenshot.

![sonarr-rtorrent](docs/assets/sonarr-rtorrent.png)

4.On the `Download Client` page, toward the bottom is the Drone configuration. Point the drone to watch `/data/complete`.

![sonarr-rtorrent](docs/assets/sonarr-rtorrent-drone.png)


### SickRage

> Dropped in favor of Sonarr, but still included incase you prefer it.

SickRage is accessible via http://YOUR.IP.ADDR.ESS:8081

Available variables:

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**


### Resilio-Sync

> Sync uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.


Web interface visible at http://YOUR.IP.ADDR.ESS:8888

Directories mounted for sync in /data/

Available variables:

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**


## Advanced Configuration

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

If SickRage is running, stop it. Go to `config/sickrage` and edit `config.ini`. Find the line that says
`handle_reverse_proxy` and change the 0 to a 1. Now start SickRage again.


## Tips and Tricks

Display all containers running in a more readable format:

```bash
clear && docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}" && echo ""
```


## Credit

I give credit where it's due and would like to give a shoutout to [LinuxServer.io](https://github.com/linuxserver). Parts of
their Dockerfiles were borrowed and modified for this seedbox setup.
