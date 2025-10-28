# Host MoongladePure

MoongladePure is an open-source blogging platform that is easy to use and customize. MoongladePure is self-hosted, which means you can host it on your own server and have full control over your data.

To host MoongladePure on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/MoongladePure
cd ~/Source/ServiceConfigs/MoongladePure
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
  web:
    depends_on:
      - moongladepure-db
    image: hub.aiursoft.com/aiursoft/moongladepure
    ports:
      - target: 5000
        published: 5000
        protocol: tcp
        mode: host
    volumes:
      - web-files:/data/files
      - web-aspnet:/root/.aspnet/
    environment:
        ConnectionStrings__AllowCache: 'False'
        ConnectionStrings__DefaultConnection: Server=db;Database=moongladepure;Uid=moongladepure;Pwd=<moongaldepure_password>;
        ConnectionStrings__DbType: MySql
        Storage__Path: /data/files
    networks:
      - internal

  db:
    image: mysql
    volumes:
      - db-files:/var/lib/mysql
    environment:
      - MYSQL_RANDOM_ROOT_PASSWORD=true
      - MYSQL_DATABASE=moongladepure
      - MYSQL_USER=moongladepure
      - MYSQL_PASSWORD=<moongaldepure_password>
    networks:
      - internal

networks:
  internal:
    driver: overlay

volumes:
  web-files:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/moongladepure/files
  web-aspnet:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/moongladepure/aspnet
  db-files:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/moongladepure/db
EOF
sudo mkdir -p /swarm-vol/moongladepure/files
sudo mkdir -p /swarm-vol/moongladepure/aspnet
sudo mkdir -p /swarm-vol/moongladepure/db
```

Then, deploy the service:

```bash title="Deploy the service"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml moongladepure --detach
```

That's it! You have successfully hosted MoongladePure on AnduinOS.

You can access MoongladePure by visiting `http://localhost:5000` in your browser.

The default username is `admin` and the default password is `admin123`.

## Uninstall

To uninstall MoongladePure, run the following commands:

```bash title="Uninstall MoongladePure"
sudo docker stack rm moongladepure
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/moongladepure -rf
```

That's it! You have successfully uninstalled MoongladePure from AnduinOS.
