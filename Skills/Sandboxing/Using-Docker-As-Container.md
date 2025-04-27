# Common Docker Tips and Tricks

The following are some useful Docker commands and techniques that can help you manage your containers and images more effectively. Each section includes explanations of when and how to use these commands.

## Install Docker

To install Docker on AnduinOS, please follow the instructions [here](../../Applications/Development/Docker/Docker.md).

## Build an Image from a Dockerfile

```bash title="Build an Image from a Dockerfile"
docker build -t image_name:tag .
```

## Run a Command Inside a Running Container

```bash title="Run a Command Inside a Running Container"
docker exec -it container_id_or_name bash
```

## Map Ports Between Host and Container

```bash title="Map Ports Between Host and Container"
docker run -p host_port:container_port image_name
```

## Use Volumes to Persist Data

```bash title="Use Volumes to Persist Data"
docker run -v /host/path:/container/path image_name
```

## Set Environment Variables in a Container

```bash title="Set Environment Variables in a Container"
docker run -e VARIABLE_NAME=value image_name
```

## Limit Container Resources

### Limit CPU Usage:

```bash title="Limit CPU Usage"
docker run --cpus="1.5" image_name
```

### Limit Memory Usage:

```bash title="Limit Memory Usage"
docker run --memory="500m" image_name
```

## Check Container Logs

```bash title="Check Container Logs"
docker logs container_id_or_name
```

## Remove Dangling Images

```bash title="Remove Dangling Images"
docker image prune -f
```

## Inspect a Container or Image

### Inspect a Container:

```bash title="Inspect a Container"
docker inspect container_id_or_name
```

### Inspect an Image:

```bash title="Inspect an Image"
docker inspect image_name:tag
```

## Use `docker-compose` to Manage Multi-Container Applications

### `docker-compose.yml` Example:

```yaml
version: '3'
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
  db:
    image: postgres:latest
    environment:
      - POSTGRES_PASSWORD=example
```

### Run the Application:

```bash title="Run the Application"
docker-compose up -d
```

## Tag and Push an Image to a Registry

### Tag the Image:

```bash title="Tag the Image"
docker tag local_image:tag username/repository:tag
```

### Push the Image:

```bash title="Push the Image"
docker push username/repository:tag
```

## Run a Container in Detached Mode

```bash title="Run a Container in Detached Mode"
docker run -d image_name
```

## Remove All Stopped Containers

```bash title="Remove All Stopped Containers"
docker container prune -f
```

## Save and Load Docker Images

### Save an Image to a File:

```bash title="Save an Image to a File"
docker save -o image.tar image_name:tag
```

### Load an Image from a File:

```bash title="Load an Image from a File"
docker load -i image.tar
```

## Pull the Latest Version of an Image

```bash title="Pull the Latest Version of an Image"
docker pull image_name:latest
```

## Stop and Remove All Containers

```bash title="Stop and Remove All Containers"
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```

## Run a Container with a Specific Restart Policy

```bash title="Run a Container with Restart Policy"
docker run --restart unless-stopped image_name
```

## Connect a Container to a Network

```bash title="Connect a Container to a Network"
docker network create my_network
docker run --network my_network image_name
```

## Run as host user

```bash title="Run as host user"
docker run --user $(id -u):$(id -g) -it container_name bash
```

## Initialize Docker Swarm as Admin

To initialize a Docker Swarm and advertise the manager node's IP address:

```bash title="Initialize Docker Swarm"
sudo docker swarm init --advertise-addr $(hostname -I | awk '{print $1}')
```

## Copy Files Between Host and Container

### To Container:

```bash title="Copy a file from the host to a container"
docker cp foo.txt container_id:/foo.txt
```

### From Container:

```bash title="Copy a file from a container to the host"
docker cp container_id:/foo.txt foo.txt
```

## MySQL Docker Backup and Restore

### Restore a MySQL Database:

```bash title="Restore a MySQL Database"
sudo docker exec -i 9cc920668c42 sh -c 'exec mysql   -u root -p"<root_password>" anduin' < ./Anduin.backup.sql
```

### Restore a MariaDB Database:

```bash title="Restore a MariaDB Database"
sudo docker exec -i 9cc920668c42 sh -c 'exec mariadb -u root -p"<root_password>" anduin' < ./Anduin.backup.sql
```

## Sort Containers by Resource Usage

### RAM Usage

```bash title="Sort Containers by RAM Usage"
sudo docker stats --no-stream --format "table {{.Name}}\t{{.Container}}\t{{.MemUsage}}" | sort -k 3 -h 
```

### CPU Usage

```bash title="Sort Containers by CPU Usage"
sudo docker stats --no-stream --format "table {{.Name}}\t{{.Container}}\t{{.CPUPerc}}" | sort -k 3 -h
```

### Unhealthy

```bash title="Sort Unhealthy Containers"
sudo docker ps  --filter "health=unhealthy" --format "table {{.ID}}\t{{.Names}}\t{{.Status}}" | sort -k 3 -h
```

### Disk Usage

```bash title="Sort Containers by Disk Usage"
sudo docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Size}}" | sort -k 3 -h
```

### Image Size

```bash title="Sort Images by Size"
sudo docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}" | sort -k 2 -h
```

## Get Disk Space Usage

```bash title="Shows the disk space used by Docker images, containers, and volumes."
sudo docker system df
```

## Remove Useless Images and Delete Killed Containers and Volumes

```bash
sudo docker system prune -a --volumes -f
```

## Browse Image Content

```bash
sudo docker run -it --entrypoint sh image_name
```

## Output Secret Value

```bash
get_docker_secret() {
  if [ -z "$1" ]; then
    echo "Usage: get_docker_secret <secret_id>"
    return 1
  fi
  secret_id=$1
  service_name="secret-reader-$secret_id"
  sudo docker service create --name "$service_name" --secret "$secret_id" alpine sh -c "cat /run/secrets/$secret_id && sleep 10"
  sleep 2
  sudo docker service logs "$service_name"
  sudo docker service rm "$service_name"
}
```

**Explanation:**

This function retrieves the value of a Docker secret by:

- Checking if a secret ID is provided.
- Creating a temporary Docker service that mounts the secret.
- Outputting the secret's content to the logs.
- Removing the temporary service after retrieval.

**When to use:**

Use this function when you need to read the value of a Docker secret, especially in situations where you need to verify the secret's content.

---

## Install `tzdata` in Dockerfile

```Dockerfile
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y tzdata && \
    echo "Etc/UTC" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
```

**Explanation:**

- Installs the `tzdata` package without interactive prompts.
- Sets the timezone to UTC.
- Reconfigures `tzdata` to apply the timezone settings.

**When to use:**

Include this in your Dockerfile when your application depends on correct timezone settings or requires `tzdata` to function properly.

---

## Install GUI Applications

You can install GUI applications in Docker containers. For example, here's how to install WeChat:

```Dockerfile
FROM ubuntu:22.04

# Install locales
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y libc-bin locales wget sudo && \
    locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y tzdata && \
    echo "Etc/UTC" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Necessary packages
RUN apt install -y dbus-x11 packagekit-gtk3-module
RUN dbus-uuidgen > /var/lib/dbus/machine-id

# Install the app
RUN wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
RUN sudo apt install -y com.qq.weixin.deepin

ENTRYPOINT ["/opt/apps/com.qq.weixin.deepin/files/run.sh"]

# To build, run:
# sudo docker build -t nautilus .

# To run, run:
# xhost +local:docker
# sudo docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri nautilus
```

**Explanation:**

- **Base Image**: Uses an Ubuntu-based image from a custom registry.
- **Locales**: Sets up locale configurations.
- **Timezone**: Installs and configures `tzdata`.
- **Dependencies**: Installs packages required for GUI applications.
- **DBus**: Generates a machine ID for D-Bus.
- **Install WeChat**: Downloads and installs WeChat using the Deepin Wine installer.
- **ENTRYPOINT**: Specifies the command to run when the container starts.

**How to Build and Run:**

- **Build the Image**:

  ```bash
  sudo docker build -t nautilus .
  ```

- **Run the Container**:

  ```bash
  xhost +local:docker
  sudo docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri nautilus
  ```

**When to use:**

Use this Dockerfile when you need to run GUI applications inside a Docker container, such as for testing or development purposes. The setup allows the container to display GUI applications on the host's X server.
