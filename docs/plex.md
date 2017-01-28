# Plex

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
