# Host Jellyfin

Jellyfin is a free software media server. It is an alternative to Plex, Emby, and other media servers. Jellyfin is the Free Software Media System that puts you in control of managing and streaming your media. It is an alternative to the proprietary Emby and Plex, to provide media from a dedicated server to end-user devices via multiple apps.

To host Jellyfin on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/Jellyfin
cd ~/Source/ServiceConfigs/Jellyfin
```

Make sure no other process is taking 1900, 7359, and 8096 ports on your machine.

```bash
function port_exist_check() {
  if [[ 0 -eq $(sudo lsof -i:"$1" | grep -i -c "listen") ]]; then
    echo "$1 is not in use"
    sleep 1
  else
    echo "Warning: $1 is occupied"
    sudo lsof -i:"$1"
    echo "Will kill the occupied process in 5s"
    sleep 5
    sudo lsof -i:"$1" | awk '{print $2}' | grep -v "PID" | sudo xargs kill -9
    echo "Killed the occupied process"
    sleep 1
  fi
}

port_exist_check 1900
port_exist_check 7359
port_exist_check 8096
```

Then, create a `docker-compose.yml` file with the following content:

```bash
cat << EOF > ./docker-compose.yml
version: '3.3' 

services:
  web:
    image: jellyfin/jellyfin
    volumes:
      - config-data:/config
      - cache-data:/cache
      - media-data:/mnt/data
    environment:
      - TZ=UTC
    ports:
      - target: 1900
        published: 1900
        protocol: udp
        mode: host
      - target: 7359
        published: 7359
        protocol: udp
        mode: host
      - target: 8096
        published: 8096
        protocol: tcp
        mode: host
    deploy:
      resources:
        limits:
          memory: 4G

volumes:
  config-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/jellyfin/config
  cache-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/jellyfin/cache
  media-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/jellyfin/media
EOF
sudo mkdir -p /swarm-vol/jellyfin/config
sudo mkdir -p /swarm-vol/jellyfin/cache
sudo mkdir -p /swarm-vol/jellyfin/media
```

Then, deploy the service:

```bash
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml jellyfin --detach
```

That's it! You have successfully hosted Jellyfin on AnduinOS.

You can access Jellyfin by visiting `http://localhost:8096` in your browser.

The default username is `root` and the default password is set during the first login.

## Uninstall

To uninstall Jellyfin, run the following commands:

```bash
sudo docker stack rm jellyfin
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash
sudo rm /swarm-vol/jellyfin -rf
```

That's it! You have successfully uninstalled Jellyfin from AnduinOS.
