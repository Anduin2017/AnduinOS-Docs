# Update Kernel Parameters

In some cases, you may want to change the kernel parameters to optimize the performance of your system. This guide will show you how to update kernel parameters on AnduinOS.

First, you need to edit the GRUB configuration file. To do this, open a terminal and run the following command:

```bash
sudo apt install vim
sudo vim /etc/default/grub
```

You will see the GRUB configuration file. Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` and add your desired kernel parameters. For example, if you want to add the `acpi=off` parameter, the line should look like this:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash hugepagesz=1G default_hugepagesz=2M intel_iommu=on iommu=pt cpufreq.default_governor=performance"
```

For example, if you want to show detailed log instead of a logo during boot, you can remove `quiet splash` from the line:

```bash
sudo sed -i 's/quiet//g; s/splash//g' /etc/default/grub
```

Then, update the GRUB configuration by running the following command:

```bash
sudo update-grub
```

Finally, reboot your system to apply the changes:

```bash
sudo reboot
```

After rebooting, the new kernel parameters will take effect. You can verify the changes by running the following command:

```bash
sudo dmesg
```
