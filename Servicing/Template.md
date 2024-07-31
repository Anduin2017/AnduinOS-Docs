# Host SomeService

SomeService is...

To host SomeService on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/SomeService
cd ~/Source/ServiceConfigs/SomeService
```

Make sure no other process is taking 1111, 2222, and 3333 ports on your machine.

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

port_exist_check 1111
port_exist_check 2222
port_exist_check 3333
```

Then, create a `docker-compose.yml` file with the following content:

```bash
cat << EOF > ./docker-compose.yml
version: '3.3' 

services:
  web:
    image: SomeService/SomeService
    volumes:
      - config-data:/config
      - cache-data:/cache
      - media-data:/mnt/data
    environment:
      - TZ=UTC
    ports:
      - target: 1111
        published: 1111
        protocol: tcp
        mode: host
      - target: 2222
        published: 2222
        protocol: tcp
        mode: host
      - target: 3333
        published: 3333
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
      device: /swarm-vol/SomeService/config
  cache-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/SomeService/cache
  media-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/SomeService/media
EOF
sudo mkdir -p /swarm-vol/SomeService/config
sudo mkdir -p /swarm-vol/SomeService/cache
sudo mkdir -p /swarm-vol/SomeService/media
```

Then, deploy the service:

```bash
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml SomeService --detach
```

That's it! You have successfully hosted SomeService on AnduinOS.

You can access SomeService by visiting `http://localhost:3333` in your browser.

The default username is `XXXXXXXXXXXXXXXXX` and the default password is `XXXXXXXXXXXXXXXX`.

## Uninstall

To uninstall SomeService, run the following commands:

```bash
sudo docker stack rm SomeService
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash
sudo rm /swarm-vol/SomeService -rf
```

That's it! You have successfully uninstalled SomeService from AnduinOS.
