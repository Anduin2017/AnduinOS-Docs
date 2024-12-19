# Host Samba

Samba is a free software re-implementation of the SMB/CIFS networking protocol. It allows file sharing between Windows and Linux systems. Samba is commonly used to share files and printers between Windows and Linux systems.

To host Samba on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash title="Prepare a clean directory"
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/samba
cd ~/Source/ServiceConfigs/samba
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

port_exist_check 139
port_exist_check 445
```

Then, create a `docker-compose.yml` file with the following content:

```bash title="Create a docker-compose.yml file"
cat << EOF > ./docker-compose.yml
version: '3.3' 

services:
  smb:
    image: andyzhangx/samba:win-fix
    volumes:
      - samba-data:/mount
    environment:
      - WORKGROUP=WORKGROUP
    ports:
      - target: 139
        published: 139
        protocol: tcp
        mode: host
      - target: 445
        published: 445
        protocol: tcp
        mode: host
    #                                                    -s <name;/path>;browsable(yes);readonly(no);guestok(yes);users(all);admins(none);writelist(none);comment(string)
    command: "-p -n -u 'USER;PASSWORD' -w 'WORKGROUP' -S -s 'media;/mount;yes;no;no;all;none;none;Media Share;create mask = 0777;directory mask = 0777;force user = nobody;force group = nogroup;force create mode = 0666;force directory mode = 0777'"
    healthcheck:
      test: ["CMD", "smbclient", "-L", "//localhost", "-U", "USER%PASSWORD"]
      interval: 30s
      timeout: 10s
      retries: 3

volumes:
  samba-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/samba-data
EOF
sudo mkdir -p /swarm-vol/samba-data
```

In the `docker-compose.yml` file, we have set the default username and password to `USER` and `PASSWORD`, while share path is `/mount`. The default workgroup is `WORKGROUP`. Respectively. You can change them to your desired values.

Then, deploy the service:

```bash title="Deploy the service"
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml samba --detach
```

That's it! You have successfully hosted Samba on AnduinOS.

You can access Samba by mounting the shared folder on your other machine. Open the File Explorer, type `\\<AnduinOS_IP>` in the address bar, and press Enter. You will be prompted to enter the username and password you specified in the `docker-compose.yml` file.

## Uninstall

To uninstall Samba, run the following commands:

```bash title="Uninstall Samba"
sudo docker stack rm samba
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash title="Remove the data, log, and config files"
sudo rm /swarm-vol/samba-data -rf
```

That's it! You have successfully uninstalled Samba from AnduinOS.
