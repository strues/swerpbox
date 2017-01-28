# rTorrent / ruTorrent

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
