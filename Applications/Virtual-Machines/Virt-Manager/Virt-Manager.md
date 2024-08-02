# Virt Manager

Virt Manager is a graphical tool for managing virtual machines. It is based on libvirt and supports KVM, QEMU, Xen, and LXC. It is written in Python and uses GTK+ for the graphical user interface.

To install Virt Manager on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install virt-manager
```

That's it. If you want to allow current user to connect to the libvirt daemon, you can run:

```bash
sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu
```

However, after installing Virt Manager, you may need to configure some settings to optimize the performance of your virtual machines.

## Allow PCIe Pass-through

In some cases, you may need to pass through a PCIe device to a virtual machine. For example, if you want your virtual machine to have direct access to a GPU.  To do this, you need to enable IOMMU in the BIOS and add the `iommu=pt` kernel parameter.

To enable IOMMU in the BIOS, you need to reboot your system, press `F2` or `Delete` to enter the BIOS settings, and enable IOMMU in the settings. On Intel PCs, it may be called `VT-d`, and on AMD PCs, it may be called `AMD-Vi`.

Then you need to [Edit kernel parameter](../../../Skills/System-Management/Update-Kernel-Parameters.md).

* `hugepagesz=1G` and `default_hugepagesz=2M` will enable huge pages with a size of 1GB and 2MB. It may improve the performance of the virtual machine.
* `intel_iommu=on` and `iommu=pt` will enable IOMMU and pass-through mode. For AMD CPUs, you can use `amd_iommu=on` and `iommu=pt`.
* `cpufreq.default_governor=performance` will set the CPU frequency governor to performance mode. It may improve the performance of the virtual machine.

Finally, my GRUB configuration file looks like this:

```bash title="GRUB configuration file"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash hugepagesz=1G default_hugepagesz=2M intel_iommu=on iommu=pt cpufreq.default_governor=performance"
```

Make sure to update the GRUB configuration and reboot your system to apply the changes.

```bash title="Update GRUB configuration"
sudo update-grub
sudo reboot
```

After rebooting, you can check if IOMMU is enabled by running:

```bash title="Check IOMMU"
#!/bin/bash
shopt -s nullglob
for d in /sys/kernel/iommu_groups/*/devices/*; do
    n=${d#*/iommu_groups/*}; n=${n%%/*}
    printf 'IOMMU Group %s ' "$n"
    lspci -nns "${d##*/}"
done;
```

If you see the IOMMU groups, it means IOMMU is enabled. You can now pass through a PCIe device to a virtual machine.

## Ignore MSRs

In some cases, you may need to ignore MSRs (Model Specific Registers). This is because some drivers may touch some MSRs that are not allowed in the virtual machine. To ignore MSRs, you need to add the `kvm.ignore_msrs=1` kernel parameter.

To do that, run the following command:

```bash title="Ignore MSRs"
echo "options kvm ignore_msrs=1" | sudo tee /etc/modprobe.d/vfio.conf
```

Then update the initramfs and reboot your system:

```bash title="Update initramfs"
sudo update-initramfs -u -k all
sudo reboot
```

That's it! Now you can pass through a PCIe device to a virtual machine.

## Offline a PCIe Device Before Passing Through

For example, if you want to pass through a GPU to a virtual machine, you need to offline the GPU before passing it through. To do this, you can follow these steps:

First, you need to know the PCI address of the GPU. You can find it by running:

```bash title="Find PCI Address"
lspci | grep VGA
```

For example, I have two Nvidia Quadro P620 GPUS. The addresses are `15:00.0` and `21:00.0`.

```bash
anduin@anduin-work-aos:~$ lspci | grep NVIDIA
15:00.0 VGA compatible controller: NVIDIA Corporation GP107GL [Quadro P620] (rev a1)
15:00.1 Audio device: NVIDIA Corporation GP107GL High Definition Audio Controller (rev a1)
21:00.0 VGA compatible controller: NVIDIA Corporation GP107GL [Quadro P620] (rev a1)
21:00.1 Audio device: NVIDIA Corporation GP107GL High Definition Audio Controller (rev a1)
```

!!! note

    In the example above, NVIDIA Quadro P620 and it's audio device are listed. And the two devices are in the same IOMMU group. You need to offline both devices.

Then you need to tell Linux kernel to unbind the GPU from the driver. You can do this by running:

!!! warning

    Update the ID in the script below to your GPU ID. For example, I want to pass through `21:00.0` and `21:00.1`, so I will update the script below to `0000:21:00.0` and `0000:21:00.1`. Update the values to your own PCIe address!

```bash title="Unbind GPU"
echo "
#!/bin/sh

PREREQ=""

prereqs()
{
   echo "$PREREQ"
}

case $1 in
prereqs)
   prereqs
   exit 0
   ;;
esac

for dev in 0000:21:00.0 0000:21:00.1 # Update the values to your own PCIe address!
do 
 echo "vfio-pci" > /sys/bus/pci/devices/$dev/driver_override 
 echo "$dev" > /sys/bus/pci/drivers/vfio-pci/bind 
done

exit 0" | sudo tee /etc/initramfs-tools/scripts/init-top/vfio.sh
sudo chmod +x /etc/initramfs-tools/scripts/init-top/vfio.sh
```

Then update the initramfs and reboot your system:

```bash title="Update initramfs"
sudo update-initramfs -u -k all
sudo reboot
```

## Enable Secure Boot for Virtual Machines

If you want to enable Secure Boot for your virtual machines, you need to ajust the settings of the virtual machine.

First, open `Virt-Manage` and create a new virtual machine. Then, go to `Edit` -> `Preferences` -> `General` and enable `Enable XML editing`.

Then, open your virtual machine. Click `Show virtual hardware details` -> `Overview` and add the following lines to the XML configuration:

```xml
<os firmware="efi">
    ...
    <firmware>
        <feature enabled="yes" name="enrolled-keys"/>
        <feature enabled="yes" name="secure-boot"/>
    </firmware>
    ...
</os>
```

## Enable simulated TPM for Virtual Machines

If you want to enable a simulated TPM for your virtual machines, you need to adjust the settings of the virtual machine.

First, install `swtpm` by running the following command on host:

```bash
sudo apt install swtpm swtpm-tools
```

Then, open `Virt-Manage` and create a new virtual machine. Then, go to `Edit` -> `Preferences` -> `General` and enable `Enable XML editing`.

Then, open your virtual machine. Click `Show virtual hardware details` -> `Overview` and add the following lines to the XML configuration:

```xml
<devices>
    ...
    <tpm model="tpm-tis">
      <backend type="emulator" version="2.0"/>
    </tpm>
    ...
</devices>
```
