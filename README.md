# SwerpBox  

[![CircleCI](https://circleci.com/gh/strues/swerpbox.svg?style=svg)](https://circleci.com/gh/strues/swerpbox)


> SwerpBox, a seedbox and media center combined with the power of  🐳 Docker.  


## Get Started

Clone this repository or upload the contents of the repository to your web server. Where you place the SwerpBox files is where all the fun happens. I recommend working out of your home directory.

Example: `/home/<USER>/swerpbox`  

Create a copy of the environment variables file with `cp env_example .env` and fill in the information to match with your environment.

The variables PGID, PUID, PLEX_UID, and PLEX_GUID must be set to the ids of the user running SwerpBox. If you aren't sure what the values of your user account are, you can find them by typing `id $(whoami)` on your server.

The output will look like this:  

```
uid=1000(swerp) gid=1000(swerp) groups=1000(swerp)
```

It is crucial that the PGID and PUID variables are correct as they map  permissions to the user.  


### Frontend

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PUID`: User UID. Default: **1000**
 - `PGID`: User group id. Default: **1000**


### rTorrent/ruTorrent

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PUID`: User UID. Default: **1000**
 - `PGID`: User group id. Default: **1000**

### Deluge

Available variables:

- `TZ`: Your timezone. Default: **America/Denver**
- `PUID`: User UID. Default: **1000**
- `PGID`: User group id. Default: **1000**

### Plex

Available variables:

 - `TZ`: Your timezone. Default: **America/Denver**
 - `PLEX_CLAIM`: Plex claim token. Get it from: **https://plex.tv/claim**
 - `ADVERTISE_IP`: Server IP address for plex. Default: **http://127.0.0.1:32400**
 - `PLEX_UID`: User UID. Default: **1000**
 - `PLEX_GID`: User group id. Default: **1000**
 - `CHANGE_CONFIG_DIR_OWNERSHIP`: Change directory ownership. Default: **false**


### Filebot


## Additional information
