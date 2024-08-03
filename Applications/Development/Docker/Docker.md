# Docker

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

To install Docker on AnduinOS, you can run:

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

To allow current user to run Docker commands without sudo, you can run:

```bash title="Allow current user to run Docker commands without sudo"
sudo usermod -aG docker $USER
sudo apt install -y uidmap
dockerd-rootless-setuptool.sh install
```

You may need `docker-compose` to manage multi-container Docker applications. To install `docker-compose`, you can run:

```bash
sudo apt install docker-compose
```

## Docker with Nvidia GPU

First, confirm that your Nvidia GPU is detected by the system:

```bash
$ sudo lspci | grep NVIDIA
01:00.0 3D controller: NVIDIA Corporation GP104GL [Tesla P4] (rev a1)
```

To list available drivers:

```bash
sudo ubuntu-drivers list --gpgpu
```

You should see a list of drivers such as:

```bash
nvidia-driver-470
nvidia-driver-470-server
nvidia-driver-535
...
```

To install the recommended driver:

```bash
sudo ubuntu-drivers install
```

To install a specific driver:

```bash
sudo ubuntu-drivers install nvidia:535
```

Reboot your system to apply the changes:

```bash
sudo reboot
```

Check the installed driver version:

```bash
nvidia-smi
```

Install Docker using the following commands:

```bash
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

Add the Nvidia Container Toolkit repository and install it:

Reference: [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

Then, install nvidia-docker2

Reference: [https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.10.0/install-guide.html](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.10.0/install-guide.html)

```bash
sudo apt-get install -y nvidia-docker2
```

Restart the Docker service:

```bash
sudo systemctl restart docker
```

Verify the GPU setup in Docker:

```bash
sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```

Clone the `gpu-burn` repository, build the Docker image, and run the GPU burn test:

```bash
git clone https://github.com/wilicc/gpu-burn
cd gpu-burn
sudo docker build -t gpu_burn .
sudo docker run --rm --gpus all gpu_burn
```

Expected output:

```bash
GPU 0: Tesla P4 (UUID: GPU-98102189-595e-4a64-3f32-3f0584ff9fe9)
Using compare file: compare.ptx
Burning for 60 seconds.
...
Tested 1 GPUs:
        GPU 0: OK
```

Now you can share the GPU with Docker-Compose

Create a `docker-compose.yml` file to share the GPU:

```yaml
version: '3.8'

services:
  cuda_app:
    image: your_image
    runtime: nvidia
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

To find CUDA images, visit [NVIDIA CUDA Docker Hub](https://hub.docker.com/r/nvidia/cuda/tags).

### Example CUDA Application

Dockerfile:

```Dockerfile
FROM nvidia/cuda:11.6.2-base-ubuntu20.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cuda

COPY hello.cu /usr/src/hello.cu
WORKDIR /usr/src

RUN nvcc -o hello hello.cu

CMD ["./hello"]
```

hello.cu:

```cpp
#include <iostream>

__global__ void helloFromGPU() {
    printf("Hello World from GPU!\n");
}

int main() {
    helloFromGPU<<<1, 1>>>();
    cudaDeviceSynchronize();
    return 0;
}
```

## Docker Desktop

!!! warning "Not recommended"

    I don't recommend using Docker Desktop on AnduinOS. Docker Desktop is designed for running Docker daemon in a virtual machine. It may mess up your system!

* Before starting Docker-Desktop, the `docker` command is provided by original Docker daemon. After starting Docker Desktop, the `docker` command is provided by Docker Desktop running in a virtual machine. This may cause confusion.
* While Docker Desktop is free for personal use, it is not free for commercial use. You may need to pay for it. And it's not open source.

If you insist on using Docker Desktop, you can run:

<!-- The link needs to be updated regularly. -->

```bash
cd ~
wget https://desktop.docker.com/linux/main/amd64/157355/docker-desktop-amd64.deb -O docker-desktop-amd64.deb
sudo dpkg -i docker-desktop-amd64.deb
sudo apt install --fix-broken -y
rm docker-desktop-amd64.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.docker.com/products/docker-desktop) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
