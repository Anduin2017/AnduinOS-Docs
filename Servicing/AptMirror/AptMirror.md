# Host an apt Mirror

`apt` is the package manager for Debian-based systems. It is used to install, update, and remove software packages. An apt mirror is a server that stores a copy of the software packages available in the official repositories. Hosting an apt mirror on AnduinOS can help you speed up the package installation process and reduce the load on the official repositories.

To host an apt mirror on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/AptMirror
cd ~/Source/ServiceConfigs/AptMirror
```

Make sure no other process is taking 5000 port on your machine.

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

port_exist_check 5000
```

Then, create a `docker-compose.yml` file with the following content:

```bash title="Create a docker-compose.yml file"
cat << EOF > ./docker-compose.yml
version: '3.3'

services:
  downloader:
    image: hub.aiursoft.com/aiursoft/internalimages/apt-mirror
    volumes:
      - apt-mirror-data:/var/spool/apt-mirror

  web_apt:
    depends_on:
      - downloader
    image: hub.aiursoft.com/aiursoft/static
    ports:
      - target: 5000
        published: 5000
        protocol: tcp
        mode: host
    volumes:
      - apt-mirror-data:/data
    entrypoint: ["sh", "-c", "/app/static --port 5000 --path /data/mirror/archive.ubuntu.com --allow-directory-browsing"]

volumes:
  apt-mirror-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/apt-mirror-data

EOF
sudo mkdir -p /swarm-vol/apt-mirror-data/mirror/archive.ubuntu.com/ubuntu
```

Then, deploy the service:

```bash title="Deploy the service"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml apt-mirror
```

That's it! You have successfully hosted apt mirror on AnduinOS.

You need to wait a day until the mirror is fully synchronized. It will download about 700GB of data.

To start downloading right now, you can run the following command:

```bash title="Start downloading right now"
sudo docker exec -it $(sudo docker ps -qf "name=apt-mirror_downloader") apt-mirror
```

You can access apt mirror by visiting `http://localhost:5000` in your browser.

## Uninstall

To uninstall apt mirror, run the following commands:

```bash title="Uninstall apt mirror"
sudo docker stack rm apt-mirror
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/apt-mirror-data -rf
```

That's it! You have successfully uninstalled apt mirror from AnduinOS.
