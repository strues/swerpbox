# Advanced


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
    -e "LETSENCRYPT_DOMAIN6=plexpy.yourdomain.com" \
    -e "LETSENCRYPT_DOMAIN7=sickrage.yourdomain.com" \
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
