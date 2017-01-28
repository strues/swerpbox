# Commands


Display all containers running in a more readable format:

```bash
clear && docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}" && echo ""
```

Display all available commands:  
`make help`  

Bash is included in all containers for debugging purposes. You can enter a container and access its shell with the following:
`docker exec -it <containerId> /bin/bash` or `docker exec -it <sb-containerName> /bin/bash`
