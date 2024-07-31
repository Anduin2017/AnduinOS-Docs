# Host GitLab

GitLab is a web-based Git repository manager with wiki and issue tracking features. GitLab is similar to GitHub, but GitLab has an open-source version, unlike GitHub. GitLab is a self-hosted Git repository manager, which means that you can host your own GitLab server on your own infrastructure.

To host GitLab on AnduinOS, run the following commands.

First, make sure Docker is installed on your machine. If not, you can install Docker by running the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Create a new folder to save the service configuration files:

```bash
# Please install Docker first
mkdir -p ~/Source/ServiceConfigs/GitLab
cd ~/Source/ServiceConfigs/GitLab
```

Make sure no other process is taking 80, 443, and 2202 ports on your machine.

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
port_exist_check 443
port_exist_check 2202
```

Then, create a `docker-compose.yml` file with the following content:

```bash
cat << EOF > ./docker-compose.yml
version: "3.6"

services:
  gitlab:
    image: gitlab/gitlab-ee
    ports:
      - target: 2202
        published: 2202
        protocol: tcp
        mode: host
      - target: 80
        published: 80
        protocol: tcp
        mode: host
      - target: 443
        published: 443
        protocol: tcp
        mode: host
    volumes:
      - gitlab-data:/var/opt/gitlab
      - gitlab-log:/var/log/gitlab
      - gitlab-config:/etc/gitlab
      - /etc/localtime:/etc/localtime:ro
      - type: tmpfs
        target: /dev/shm
        tmpfs:
          size: 2147483648 # 2GB
    tmpfs:
      - /tmp:size=2G
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost'
        gitlab_rails['gitlab_shell_ssh_port'] = 2202
        gitlab_sshd['enable'] = true
        gitlab_sshd['listen_address'] = '[::]:2202'
        gitlab_rails['gitlab_default_theme'] = 2
        letsencrypt['enabled'] = false
        nginx['listen_port'] = 80
        nginx['listen_https'] = false
        nginx['redirect_http_to_https'] = false
        nginx['proxy_protocol'] = false
        nginx['http2_enabled'] = true
        prometheus_monitoring['enable'] = false
        sidekiq['metrics_enabled'] = false
        puma['exporter_enabled'] = false
    deploy:
      resources:
        limits:
          memory: 22G

volumes:
  gitlab-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/gitlab/data
  gitlab-log:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/gitlab/log
  gitlab-config:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /swarm-vol/gitlab/config
EOF
sudo mkdir -p /swarm-vol/gitlab/data
sudo mkdir -p /swarm-vol/gitlab/log
sudo mkdir -p /swarm-vol/gitlab/config
```

Then, deploy the service:

```bash
sudo docker swarm init  --advertise-addr $(hostname -I | awk '{print $1}')
sudo docker stack deploy -c docker-compose.yml gitlab --detach
```

That's it! You have successfully hosted GitLab on AnduinOS.

You can access GitLab by visiting `http://localhost` in your browser.

The default `root` password is located at `/swarm-vol/gitlab/config/initial_root_password`.

## Uninstall

To uninstall GitLab, run the following commands:

```bash
sudo docker stack rm gitlab
sleep 20 # Wait for the stack to be removed
sudo docker system prune -a --volumes -f # Clean up used volumes and images
```

To also remove the data, log, and config files, run the following commands:

```bash
sudo rm /swarm-vol/gitlab -rf
```

That's it! You have successfully uninstalled GitLab from AnduinOS.
