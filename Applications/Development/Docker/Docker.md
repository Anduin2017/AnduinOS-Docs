# Docker

To install Docker on AnduinOS, you can run:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

To allow current user to run Docker commands without sudo, you can run:

```bash
sudo usermod -aG docker $USER
```

You may need `docker-compose` to manage multi-container Docker applications. To install `docker-compose`, you can run:

```bash
sudo apt install docker-compose
```

## Docker Desktop

I don't recommend using Docker Desktop on AnduinOS. Docker Desktop is designed for runnning Docker daemon in a virtual machine. It may mess up your system because:

* Before starting Docker-Desktop, the `docker` command is provided by original Docker daemon. After starting Docker Desktop, the `docker` command is provided by Docker Desktop running in a virtual machine. This may cause confusion.

If you insist on using Docker Desktop, you can run:

<!-- The link needs to be updated regularly. -->

```bash
wget https://desktop.docker.com/linux/main/amd64/157355/docker-desktop-amd64.deb
sudo dpkg -i docker-desktop-amd64.deb
sudo apt install --fix-broken -y
rm docker-desktop-amd64.deb
```
