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
