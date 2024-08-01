# Host SQL Server

SQL Server is a relational database management system developed by Microsoft. It is a powerful database that is widely used in the industry.

To host SQL Server on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/SQLServer
cd ~/Source/ServiceConfigs/SQLServer
```

Make sure no other process is taking 1433 port on your machine.

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

port_exist_check 1433
```

Then, create a `docker-compose.yml` file with the following content:

```bash
cat << EOF > ./docker-compose.yml
version: '3.3' 

services:
  sqlserver:
    image: mcr.microsoft.com/mssql/server:2019-latest
    ports:
      - "1433:1433"
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
    volumes:
      - sqlserver-data:/var/opt/mssql

volumes:
  sqlserver-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/sqlserver/data
EOF
sudo mkdir -p /swarm-vol/sqlserver/data
```

Then, deploy the service:

```bash
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml sqlserver --detach
```

That's it! You have successfully hosted SQL Server on AnduinOS.

The default user is `sa` and the password is `YourStrong!Passw0rd`.

To manage your SQL Server, it is suggested to install Azure Data Studio. You can follow the instructions [here](../../Applications/Database-Tools/Azure-Data-Studio/Azure-Data-Studio.md).

## Uninstall

To uninstall SQL Server, run the following commands:

```bash
sudo docker stack rm sqlserver
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash
sudo rm /swarm-vol/sqlserver -rf
```

That's it! You have successfully uninstalled SQL Server from AnduinOS.
