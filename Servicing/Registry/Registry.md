# Host Registry

Registry is a self-hosted docker registry that allows you to store and manage your docker images. It is similar to Docker Hub, but it is self-hosted and can be used for private repositories.

To host Registry on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/Registry
cd ~/Source/ServiceConfigs/Registry
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

port_exist_check 8080
```

Then, create a `docker-compose.yml` file with the following content:

```bash title="Create a docker-compose.yml file"
cat << EOF > ./docker-compose.yml
version: '3.9'

services:
  registry-ui:
    depends_on:
      - registry-server
    image: joxit/docker-registry-ui:main
    ports:
      - target: 80
        published: 8080
        protocol: tcp
        mode: host
    networks:
      - net
    environment:
      - SINGLE_REGISTRY=true
      - REGISTRY_TITLE=My Registry
      - DELETE_IMAGES=true
      - SHOW_CONTENT_DIGEST=true
      - NGINX_PROXY_PASS_URL=http://registry-server:5000
      - SHOW_CATALOG_NB_TAGS=true
      - CATALOG_MIN_BRANCHES=1
      - CATALOG_MAX_BRANCHES=1
      - TAGLIST_PAGE_SIZE=100
      - REGISTRY_SECURED=false
      - CATALOG_ELEMENTS_LIMIT=1000
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
      update_config:
        order: start-first

  registry-server:
    image: registry
    volumes:
      - registry-data:/var/lib/registry
    networks:
      - net
    environment:
      REGISTRY_HTTP_HEADERS_Access-Control-Allow-Origin: '[https://hub.aiursoft.cn]' # Replace with your domain
      REGISTRY_HTTP_HEADERS_Access-Control-Allow-Methods: '[HEAD,GET,OPTIONS,DELETE]'
      REGISTRY_HTTP_HEADERS_Access-Control-Allow-Credentials: '[true]'
      REGISTRY_HTTP_HEADERS_Access-Control-Allow-Headers: '[Authorization,Accept,Cache-Control]'
      REGISTRY_HTTP_HEADERS_Access-Control-Expose-Headers: '[Docker-Content-Digest]'
      REGISTRY_STORAGE_DELETE_ENABLED: 'true'
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
      update_config:
        order: start-first

  registry-cleaner:
    depends_on:
      - registry-server
    image: alpine:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    entrypoint:
      - "/bin/sh"
      - "-c"
      - |
        echo "Installing docker";
        apk add --no-cache docker;
        echo "Starting registry cleaner";
        sleep 20;
        docker ps --filter name=registry-server -q | xargs -r -I {} docker exec {} registry garbage-collect /etc/docker/registry/config.yml --delete-untagged=true;
        echo "Garbage collection done. Sleeping infinitely.";
        sleep infinity;
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
      update_config:
        order: start-first

volumes:
  registry-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/registry-data

networks:
  net:
    driver: overlay
EOF
sudo mkdir -p /swarm-vol/registry-data
```

Then, deploy the service:

```bash title="Deploy the service"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml registry --detach
```

That's it! You have successfully hosted registry on AnduinOS.

You can access registry by visiting `http://localhost:8080` in your browser.

## Uninstall

To uninstall Registry, run the following commands:

```bash title="Uninstall Registry"
sudo docker stack rm registry
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/registry-data -rf
```

That's it! You have successfully uninstalled Registry from AnduinOS.
