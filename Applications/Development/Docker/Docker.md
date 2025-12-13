# Docker

!!! tip "AnduinOS Verified App - Open Source"

    Docker is an AnduinOS verified app. It runs flawlessly on AnduinOS with easy installation and automatic updates.

Docker is a set of platform-as-a-service products that use OS-level virtualization to deliver software in packages called containers.

To install Docker on AnduinOS, run the following commands:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

To quickly learn how to use Docker, visit the [official Docker documentation](https://docs.docker.com/get-started/). You can also view our quick Docker handbook [here](../../../Skills/Sandboxing/Using-Docker-As-Container.md).

## Manage Docker as a Non-Root User

By default, the Docker daemon runs as `root`. To run Docker commands without prepending `sudo`, you have two options based on your security needs.

### Option 1: Add User to Docker Group (Recommended for Personal Use)

This method allows your current user to control the system-wide Docker daemon. This is the most convenient method for development.

```bash title="Allow current user to run Docker commands"
sudo usermod -aG docker $USER
```

**After running this command, you must log out and log back in (or restart your computer) for the changes to take effect.**

!!! warning "Security Notice: Root Equivalence"

    By adding your user to the `docker` group, you are granting **Root Equivalence**.

    * **Global Scope:** You are interacting with the system-wide socket at `/var/run/docker.sock`.
    * **Risk:** Any process with access to the Docker daemon can effectively become `root` on the host system (e.g., by mounting the host's root filesystem `/` into a container). 
    * **Context:** This is standard practice for local development environments but requires you to trust the applications you run.

### Option 2: Rootless Docker (Isolated Scope)

If you need strict isolation (e.g., for multi-user environments) and do not want to share the system Docker daemon, you can use Rootless Docker.

```bash title="Configure Rootless Docker"
sudo apt install -y uidmap
dockerd-rootless-setuptool.sh install
```

This creates a separate Docker instance using user namespaces. The socket path will differ, and containers will not have root access to the host by default.

## Docker Compose

Modern Docker installations include the Docker Compose plugin by default. You can verify it is installed by running:

```bash
docker compose version
```

!!! note "Docker Compose v2"

    Docker Compose v2 is the latest version and is recommended for all users.

    Some older documentation may still reference Docker Compose v1, with command `docker-compose` instead of `docker compose`. These commands are functionally equivalent.

### Enable Swarm Mode (Optional)

If you need to use Docker Swarm features or deploy stacks across multiple nodes:

```bash
sudo docker swarm init --advertise-addr $(hostname -I | awk '{print $1}')
```

For more details on managing container applications, visit our [document](../../../Skills/Sandboxing/Using-Docker-As-Container.md).

## Docker with Nvidia GPU

If your system features an Nvidia GPU, Docker can utilize it for hardware acceleration (CUDA).

### 1. Verification & Drivers

First, confirm your Nvidia GPU is detected:

```bash title="Check Nvidia GPU hardware"
lspci | grep -i nvidia
```

Ensure you have the proprietary Nvidia drivers installed. Refer to the [suspicious link removed].

Verify the driver status:

```bash
nvidia-smi
```

### 2. Install Nvidia Container Toolkit

If you haven't installed Docker yet, do so now (see the top of this page). Then, install the Nvidia Container Toolkit:

*Reference: [Nvidia Container Toolkit Install Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)*

```bash title="Install Nvidia Toolkit"
# Add the repository
curl -fsSL [https://nvidia.github.io/libnvidia-container/gpgkey](https://nvidia.github.io/libnvidia-container/gpgkey) | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L [https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list](https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list) | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install packages
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit nvidia-docker2

# Restart Docker to apply changes
sudo systemctl restart docker
```

### 3. Verification

Verify that Docker can see your GPU:

```bash
sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```

### 4. Advanced: GPU in Docker Swarm

Using GPUs in Swarm mode requires manual configuration of the Docker daemon resources.

```bash title="Configuring Docker Daemon for Swarm GPU"
echo "Configuring docker daemon for Nvidia GPU..."

# Get the GPU UUID cleanly
GPU_ID=$(nvidia-smi --query-gpu=gpu_uuid --format=csv,noheader)
echo "Detected GPU_ID: $GPU_ID"

# Backup existing config
if [ -f /etc/docker/daemon.json ]; then
    sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
fi

# Write new configuration
sudo tee /etc/docker/daemon.json <<EOF
{
  "runtimes": {
    "nvidia": {
      "path": "/usr/bin/nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "default-runtime": "nvidia",
  "node-generic-resources": [
    "NVIDIA-GPU=$GPU_ID"
  ]
}
EOF

# Update Nvidia runtime config
sudo sed -i 's/#swarm-resource = "DOCKER_RESOURCE_GPU"/swarm-resource = "DOCKER_RESOURCE_GPU"/' /etc/nvidia-container-runtime/config.toml

sudo systemctl restart docker
```

Now you can deploy a Swarm service with GPU resources:

```bash title="Deploy a GPU service"
# Ensure Swarm is initialized
docker swarm init --advertise-addr $(hostname -I | awk '{print $1}') || true

docker service create --replicas 1 \
  --name tensor-qs \
  --generic-resource "NVIDIA-GPU=0" \
  tomlankhorst/tensorflow-quickstart
```

Check the logs to confirm execution:

```bash
docker service logs tensor-qs
```

Clean up:

```bash
docker service rm tensor-qs
```

#### GPU in Docker Compose (v2)

To request GPU resources in a `docker-compose.yml` file:

```yaml
services:
  cuda_app:
    image: nvidia/cuda:11.6.2-base-ubuntu20.04
    command: nvidia-smi
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## Docker Desktop

!!! warning "Not Recommended for Linux Users"

    **We strongly discourage using Docker Desktop on AnduinOS.**

    Docker Desktop runs the Docker daemon inside a **Virtual Machine (VM)**, which adds unnecessary overhead and complexity compared to the native Linux Docker engine. It may also conflict with your native Docker installation.

    Furthermore, Docker Desktop is proprietary software and may require a paid subscription for commercial use.

If you absolutely must use it (e.g., for specific GUI features), you can install the `.deb` package manually:

```bash
cd ~
wget [https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb](https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb) -O docker-desktop-amd64.deb
sudo apt install ./docker-desktop-amd64.deb -y
rm docker-desktop-amd64.deb
```


!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.docker.com/products/docker-desktop) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
