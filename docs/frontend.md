# Frontend


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
