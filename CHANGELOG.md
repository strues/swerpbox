# Change Log

## [January 29, 2017]

- Removed nginx from rTorrent / ruTorrent container.
- ruTorrent is cloned from Github and created on the host at first run.
- ruTorrent is now accessible within `srv/public/rutorrent/`
- Create data only container for the srv directory.
- Provide scripts to setup a fresh OS.

## [January 27, 2017]
- Added Sonarr
- Remove Filebot

## [January 18, 2017]
- Fixes reverse proxying for services
- AddSSL and subdomains

## [January 17, 2017]
- Setup script for Docker and Docker-Compose for Ubuntu Xenial release.
- SickRage container
