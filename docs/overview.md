# Overview

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


### Directory Structure

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
