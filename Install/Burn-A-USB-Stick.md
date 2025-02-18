# Bare-mental Installation - Make a USB installer

First, [download the latest release of AnduinOS](./Download-AnduinOS.md).

Then, create a bootable USB drive with the downloaded ISO file. Obviously, you need a USB drive with at least 2GB of storage.

## Windows

---

If you are using a Windows machine, you can use Rufus to create a bootable USB drive.

!!! note "Rufus"
    You can download Rufus from the [official website](https://rufus.ie/).

!!! warning "Use `dd` mode in Rufus instead of `ISO` mode!"

    When using Rufus, make sure to select the `dd` mode to create a bootable USB drive. This will ensure that the USB drive is bootable on both UEFI and legacy BIOS systems.

## Linux

---

If you are using a Linux machine, you can use the `dd` command to burn the ISO file to a USB drive.

First, you must identify the device name of the USB drive. You can use the `lsblk` command to list all block devices on your system.

```shell title="List block devices"
sudo fdisk -l
```

Then, use the `dd` command to burn the ISO file to the USB drive. Replace `<device>` with the device name of the USB drive.

```shell title="Burning ISO to USB using dd on Linux"
sudo dd if=./AnduinOS.iso of=<device> status=progress oflag=sync bs=4M
```

!!! warning "Data Loss!"

    This command will erase all data on the USB drive. Make sure to back up your data before running this command.

Then, boot the computer from the USB drive and follow the on-screen instructions to install AnduinOS.
