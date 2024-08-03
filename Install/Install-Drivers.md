# Install Driver

After installing AnduinOS, hopefully all devices are functioning properly. However, if you find that some devices are not working as expected, you may need to install additional drivers. This guide will show you how to install drivers on AnduinOS.

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

## After installation

After installing the drivers, you may need to [Select best APT source](./Select-Best-Apt-Source.md)
