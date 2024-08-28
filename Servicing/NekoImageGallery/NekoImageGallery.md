# Host NekoImageGallery

NekoImageGallery is an image gallery service that provides image search and image similarity search. It is a service that provides image search and image similarity search. It is an alternative to the proprietary image search services, to provide image search and image similarity search from a dedicated server to end-user devices via multiple apps.

To host NekoImageGallery on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/NekoImageGallery
cd ~/Source/ServiceConfigs/NekoImageGallery
```

Make sure no other process is taking 8000, and 5000 ports on your machine.

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

port_exist_check 8000
port_exist_check 5000
```

Then, create a `docker-compose.yml` file with the following content:

```bash title="Create a docker-compose.yml file"
cat << EOF > ./docker-compose.yml
version: '3.3'

services:
  webapp:
    image: hub.aiursoft.cn/edgeneko/nekoimagegallery.app
    ports:
      - target: 5000
        published: 5000
        protocol: tcp
        mode: host
    environment:
      - OVERRIDE_API_URL=http://localhost:8000

  server:
    image: hub.aiursoft.cn/edgeneko/neko-image-gallery:edge-cpu
    ports:
      - target: 8000
        published: 8000
        protocol: tcp
        mode: host
    networks:
      - internal
    volumes:
      - neko-image-gallery-local:/opt/NekoImageGallery/static
    depends_on:
      - qdrant_database
    environment:
      - APP_ACCESS_PROTECTED=True
      - APP_QDRANT__COLL=NekoImg-v4
      - APP_QDRANT__HOST=qdrant_database
      - APP_OCR_SEARCH__OCR_MIN_CONFIDENCE=0.05
      - APP_ADMIN_API_ENABLE=True
      - APP_STORAGE__METHOD=local
    secrets:
      - source: neko-image-gallery-access-token
        target: app_access_token
      - source: neko-image-gallery-admin-token
        target: app_admin_token

  qdrant_database:
    image: qdrant/qdrant
    networks:
      - internal
    volumes:
      - neko-image-gallery-vector-db:/qdrant/storage:z

volumes:
  neko-image-gallery-vector-db:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/neko-image-gallery/vector_db
  neko-image-gallery-local:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/neko-image-gallery/local_images/

networks:
  internal:
    driver: overlay

secrets:
  neko-image-gallery-access-token:
    external: true
  neko-image-gallery-admin-token:
    external: true
EOF
sudo mkdir -p /swarm-vol/neko-image-gallery/vector_db
sudo mkdir -p /swarm-vol/neko-image-gallery/local_images
```

You need to create two secrets for the service. Run the following commands to create the secrets:

```bash title="Create secrets"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')

function create_secret() {
    secret_name=$1
    known_secrets=$(sudo docker secret ls --format '{{.Name}}')
    if [[ $known_secrets != *"$secret_name"* ]]; then
        echo "Please enter $secret_name secret"
        read secret_value
        echo $secret_value | sudo docker secret create $secret_name -
    fi
}

create_secret neko-image-gallery-access-token
create_secret neko-image-gallery-admin-token
```

Then, deploy the service:

```bash title="Deploy the service"
sudo docker stack deploy -c docker-compose.yml neko-image-gallery --detach
```

That's it! You have successfully hosted NekoImageGallery on AnduinOS.

You can access NekoImageGallery by visiting `http://localhost:5000` in your browser.

The default password is set as the secret you created during the deployment.

## Import photos

To view photos in the gallery, you need to copy photos to the gallery folder. The gallery folder is located at `/swarm-vol/neko-image-gallery/local_images/`.

```bash title="Copy photos to the gallery"
sudo cp -v /path/to/your/photos/* /swarm-vol/neko-image-gallery/local_images/
```

Then you need to let the service know that there are new photos in the gallery. You can do this by re-indexing the gallery. To re-index the gallery, run the following commands:

```bash title="Re-index the gallery"
containerId=$(sudo docker ps -qf "name=neko-image-gallery_server")
sudo docker exec -it $containerId python main.py local-index /opt/NekoImageGallery/static
```

## Uninstall

To uninstall NekoImageGallery, run the following commands:

```bash title="Uninstall NekoImageGallery"
sudo docker stack rm neko-image-gallery
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/neko-image-gallery -rf
```

That's it! You have successfully uninstalled NekoImageGallery from AnduinOS.
