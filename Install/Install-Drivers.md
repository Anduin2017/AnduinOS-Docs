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

## Intel NPU Driver

For some models of Intel CPU including `MeteorLake`, `ArrowLake` and `LunarLake`, you may notice that the Intel NPU is not working. To enable the Intel NPU, you need to install the Intel NPU driver.

Please download and install the driver following [Intel NPU Driver Installation Guide](https://github.com/intel/linux-npu-driver/releases/latest).

After installing the driver, reboot your system, and you will see device: `/dev/accel/accel0`.

You need to set the render group for the device:

```bash title="Set the render group for the device"
# set the render group for accel device
sudo chown root:render /dev/accel/accel0
sudo chmod g+rw /dev/accel/accel0
# add user to the render group
sudo usermod -a -G render $USER
# user needs to restart the session to use the new group (log out and log in)
```

You can use the NPU to run some AI models, like `DeepSeek R1`. For more details about how to use NPU to deploy AI models, please refer to the [Blog](https://anduin.aiursoft.cn/post/2025/2/3/deepseek-r1-32b-with-npu).

## Xbox Controller Driver

By default, AnduinOS supports Xbox controllers. However you may encounter issues with the latest Xbox controllers, such as the Xbox Series X controller.

The issue may be like when you press `LT` or `RT`, the controller will not respond correctly. In this case, you need to install the `xpadneo` driver.

To read more about the `xpadneo` driver, please refer to the [xpadneo GitHub repository](https://github.com/atar-axis/xpadneo).

You can install the `xpadneo` driver by running the following commands:

```bash title="Install xpadneo driver"
git clone https://github.com/atar-axis/xpadneo.git
cd xpadneo
sudo ./install.sh
```

And the reboot your system. If you have previously connected the Xbox controller, you need to remove it from the Bluetooth devices and re-pair it.

## Build the Kernel

In case you bought very latest hardware, you may need to build the kernel from source to get the latest drivers. Please refer to the [Kernel Compilation](../Skills/Developing/Build-Your-Own-Kernel.md) guide for more information.
