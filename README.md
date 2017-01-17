# SwerpBox

SwerpBox, a seedbox and media center combined with the power of  🐳 Docker.  


## Get Started

Clone this repository or upload the contents of the repository to your web server. Where you place the SwerpBox files is where all of your activities will take place. I recommend working out of your home directory.

Example: `/home/<USER>/swerpbox`  

Create a copy of the environment variables file with `cp env_example .env` and fill in the information to match with your environment.

The variables PGID, PUID, PLEX_UID, and PLEX_GUID must be set to the ids of the user running SwerpBox. If you aren't sure what the values of your user account are, you can find them by typing `id $(whoami)` on your server.

The output will look like this:  

```
uid=1000(swerp) gid=1000(swerp) groups=1000(swerp)
```

It is crucial that the PGID and PUID variables are correct as they map  permissions to the user.  


### Frontend


### rTorrent/ruTorrent


### Deluge


### Plex


### Filebot


## Additional information
