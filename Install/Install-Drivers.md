# Install Driver

After installing AnduinOS, hopefully all devices are functioning properly. However, if you find that some devices are not working as expected, you may need to install additional drivers. This guide will show you how to install drivers on AnduinOS.

!!! note "Non-open source drivers"

    Some drivers are not open source and may have licensing restrictions. Please make sure you have the right to use these drivers before installing them.

## Automatic installation

To install drivers automatically, open the terminal and run the following command:

```bash title="Install drivers automatically"
sudo apt update
sudo ubuntu-drivers install
```

This command will install the recommended drivers for your system. After the installation is complete, reboot your system.

## Nvidia Graphics Driver

To install the Nvidia graphics driver, open the terminal and run the following command:

```bash title="List available drivers"
sudo ubuntu-drivers list --gpgpu
```

You will see a list of available drivers. To install the recommended driver, run the following command:

```bash
anduin@anduin-station-u:~$ sudo ubuntu-drivers list --gpgpu
nvidia-driver-418-server, (kernel modules provided by nvidia-dkms-418-server)
nvidia-driver-470-server, (kernel modules provided by linux-modules-nvidia-470-server-generic-hwe-22.04)
nvidia-driver-535, (kernel modules provided by linux-modules-nvidia-535-generic-hwe-22.04)
nvidia-driver-470, (kernel modules provided by linux-modules-nvidia-470-generic-hwe-22.04)
nvidia-driver-545, (kernel modules provided by nvidia-dkms-545)
nvidia-driver-535-server, (kernel modules provided by linux-modules-nvidia-535-server-generic-hwe-22.04)
nvidia-driver-390, (kernel modules provided by nvidia-dkms-390)
nvidia-driver-450-server, (kernel modules provided by nvidia-dkms-450-server)
```

For example, if you want to install the Nvidia driver 545, run the following command:

```bash title="Install Nvidia driver 545"
sudo apt install nvidia-driver-545
```

After the installation is complete, reboot your system.

### Manually install the Nvidia driver

In case you couldn't install Canonical's Nvidia driver, you can download the driver from the [Nvidia website](https://www.nvidia.com/en-us/drivers/) and install it manually.

Search for the driver that matches your graphics card and download it. Then, run the following commands to install the driver:

```bash title="Install the Nvidia driver manually"
sudo apt install gcc make build-essential
sudo systemctl isolate multi-user.target
sudo systemctl stop gdm
sudo chmod +x NVIDIA-Linux-x86_64-470.103.01.run
sudo ./NVIDIA-Linux-x86_64-470.103.01.run
```

For more information, please read the [Nvidia driver installation guide](./Install-Nvidia-Drivers.md).

## Intel Graphics Driver

Intel usually will merge latest drivers and packages to the Linux kernel. However, some modules, like `libva`, `vaapi`, `vulkan`, and `intel-media-driver`, may need to be installed separately.

To install the Intel graphics driver, you need to follow the [Intel Graphics Installer for Linux](https://dgpu-docs.intel.com/driver/client/overview.html) guide.

For example:

```bash title="install the intel-graphics PPA and the necessary compute and media packages"
# Please refer to the official Intel Graphics Installer for Linux guide for the latest instructions
sudo apt-get update

# Add the intel-graphics PPA for 24.10
sudo add-apt-repository -y ppa:kobuk-team/intel-graphics

# Install the compute-related packages
sudo apt-get install -y libze-intel-gpu1 libze1 intel-ocloc intel-opencl-icd clinfo intel-gsc

# Install the media-related packages
sudo apt-get install -y intel-media-va-driver-non-free libmfx1 libmfx-gen1 libvpl2 libvpl-tools libva-glx2 va-driver-all vainfo
```

## Build the Kernel

In case you bought very latest hardware, you may need to build the kernel from source to get the latest drivers. Please refer to the [Kernel Compilation](../Skills/Developing/Build-Your-Own-Kernel.md) guide for more information.
