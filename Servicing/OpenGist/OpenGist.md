# Host OpenGist

Opengist is a self-hosted pastebin powered by Git. All snippets are stored in a Git repository and can be read and/or modified using standard Git commands, or with the web interface. It is similiar to GitHub Gist, but open-source and could be self-hosted.

To host OpenGist on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/opengist
cd ~/Source/ServiceConfigs/opengist
```

Make sure no other process is taking 6157 port on your machine.

```bash title="Check if the ports are occupied"
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

port_exist_check 6157
```

Then, create a `docker-compose.yml` file with the following content:

```bash title="Create a docker-compose.yml file"
cat << EOF > ./docker-compose.yml
version: '3.3' 

services:
  web:
    image: ghcr.io/thomiceli/opengist:1.7
    volumes:
      - gist-data:/opengist
    ports:
      - target: 6157
        published: 6157
        protocol: tcp
        mode: host
    deploy:
      resources:
        limits:
          memory: 4G

volumes:
  gist-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/gist-data
EOF
sudo mkdir -p /swarm-vol/gist-data
```

Then, deploy the service:

```bash title="Deploy the service"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml opengist --detach
```

That's it! You have successfully hosted OpenGist on AnduinOS.

You can access OpenGist by visiting `http://localhost:6157` in your browser.

## Uninstall

To uninstall OpenGist, run the following commands:

```bash title="Uninstall OpenGist"
sudo docker stack rm opengist
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/opengist -rf
```

That's it! You have successfully uninstalled OpenGist from AnduinOS.
