# Host NextCloud

NextCloud is a free and open-source file hosting service that allows you to store your files in a centralized location and sync them across devices. NextCloud is an alternative to proprietary services like Dropbox, Google Drive, and Microsoft OneDrive. NextCloud is self-hosted, which means you can host it on your own server and have full control over your data.

To host NextCloud on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/nextcloud
cd ~/Source/ServiceConfigs/nextcloud
```

Make sure no other process is taking 80 port on your machine.

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

port_exist_check 80
```

Then, create a `docker-compose.yml` file with the following content:

```bash
cat << EOF > ./docker-compose.yml
version: '3'

services:
  web:
    image: nextcloud:stable
    networks: 
      - internal
    depends_on:
      - nextclouddb
      - redis
    ports:
      - target: 80
        published: 80
        protocol: tcp
        mode: host
    volumes:
      - nextcloud-config:/var/www/html/config
      - nextcloud-custom-apps:/var/www/html/custom_apps
      - nextcloud-data:/mnt/data
    environment:
      - TZ=UTC
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_PASSWORD=dbpassword
      - MYSQL_HOST=nextclouddb
      - REDIS_HOST=redis
      - NEXTCLOUD_DATA_DIR=/mnt/data
      - NEXTCLOUD_TRUSTED_DOMAINS=localhost
      - PHP_MEMORY_LIMIT=1G
      - PHP_UPLOAD_LIMIT=1G
      - PHP_OPCACHE_ENABLE=1
      - PHP_OPCACHE_MEMORY_CONSUMPTION=1024
    deploy:
      resources:
        limits:
          memory: 16384M

  cron:
    image: alpine
    networks: 
      - internal
    depends_on:
      - nextcloud
    entrypoint: ["/bin/sh", "-c", "apk add curl && sleep 20 && while true; do sleep 300; curl -s https://web/cron.php; done"]
    deploy:
      resources:
        limits:
          memory: 128M

  nextclouddb:
    image: mysql
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    networks: 
      - internal
    volumes:
      - nextcloud-db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=root_dbpassword
      - MYSQL_PASSWORD=dbpassword
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
    deploy:
      resources:
        limits:
          memory: 8192M

  redis:
    image: redis:alpine
    volumes:
      - nextcloud-redis:/data
    networks: 
      - internal
    deploy:
      resources:
        limits:
          memory: 8192M

networks:
  internal:
    driver: overlay

volumes:
  nextcloud-db:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/nextcloud/db
  nextcloud-redis:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/nextcloud/redis
  nextcloud-config:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/nextcloud/config
  nextcloud-custom-apps:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/nextcloud/custom_apps
  nextcloud-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/nextcloud/data
EOF
sudo mkdir -p /swarm-vol/nextcloud/db
sudo mkdir -p /swarm-vol/nextcloud/redis
sudo mkdir -p /swarm-vol/nextcloud/config
sudo mkdir -p /swarm-vol/nextcloud/custom_apps
sudo mkdir -p /swarm-vol/nextcloud/data
```

Then, deploy the service:

```bash
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml nextcloud --detach
```

You need to update the permission for `/mnt/data` inside the container. You can do this by running the following command:

```bash
sudo docker exec -it $(sudo docker ps -qf "name=nextcloud_web") chown -R www-data:www-data /mnt/data
```

You can access NextCloud by visiting `http://localhost` in your browser.

The default user is set during the first login.

During initial setup, it may ask you the password for the database. You can use the following credentials:

* Database: nextcloud
* User: nextcloud
* Password: dbpassword

That's it! You have successfully hosted NextCloud on AnduinOS.

## Uninstall

To uninstall NextCloud, run the following commands:

```bash
sudo docker stack rm nextcloud
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash
sudo rm /swarm-vol/nextcloud -rf
```

That's it! You have successfully uninstalled NextCloud from AnduinOS.
