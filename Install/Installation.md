# AnduinOS Installation Guide

## Download AnduinOS

---

Before installing AnduinOS, you need to download the ISO file from the releases page.

[Download AnduinOS (ISO)](https://download.anduinos.com/){ .md-button .md-button--primary }

It is suggested to use bit-torrent to download the ISO file. You can find the torrent file on the releases page.

## Verify the ISO sha256 checksum

After downloading the ISO file, you should verify the integrity of the file to ensure that it has not been tampered with.

To verify the ISO file, you can use the `sha256sum` command on Linux or macOS, or the `7-Zip` software on Windows.

```bash title="Verify ISO file on Linux or macOS"
sha256sum ./AnduinOS.iso
```

Please compare the output of the `sha256sum` command with the checksum provided on the releases page (File ends with `.sha256`). If the checksums match, the ISO file is valid and has not been tampered with.

## Virtual Machine Installation

---

First, download AnduinOS from releases page.

Then, create a new virtual machine with any virtualization software (e.g. VirtualBox, VMware, etc.) and attach the downloaded ISO file to the virtual machine.

Finally, boot the virtual machine and follow the on-screen instructions to install AnduinOS.

!!! warning "Disable Secure Boot"

    Make sure to disable Secure Boot in the virtual machine settings before booting from the ISO file. Secure Boot can prevent the installation of unsigned operating systems. AnduinOS is not signed, so it will not boot with Secure Boot enabled.

---

## Bare-mental Installation - Make a USB installer

First, download the latest release of AnduinOS from the releases page.

### Windows

---

If you are using a Windows machine, you can use Rufus to create a bootable USB drive.

!!! note "Rufus"
    You can download Rufus from the [official website](https://rufus.ie/).

!!! warning "Use `dd` mode in Rufus instead of `ISO` mode!"

    When using Rufus, make sure to select the `dd` mode to create a bootable USB drive. This will ensure that the USB drive is bootable on both UEFI and legacy BIOS systems.

### Linux

---

If you are using a Linux machine, you can use the `dd` command to burn the ISO file to a USB drive.

First, you must identify the device name of the USB drive. You can use the `lsblk` command to list all block devices on your system.

```shell title="List block devices"
sudo fdisk -l
```

Then, use the `dd` command to burn the ISO file to the USB drive. Replace `<device>` with the device name of the USB drive.

```shell title="Burning ISO to USB using dd on Linux"
sudo dd if=./AnduinOS-jammy-1.0.0-2407181704.iso of=<device> status=progress oflag=sync bs=4M
```

!!! warning "Data Loss"

    This command will erase all data on the USB drive. Make sure to back up your data before running this command.

Then, boot the computer from the USB drive and follow the on-screen instructions to install AnduinOS.

!!! warning "Disable Secure Boot"

    Make sure to disable Secure Boot in the BIOS settings before booting from the USB drive. Secure Boot can prevent the installation of unsigned operating systems. AnduinOS is not signed, so it will not boot with Secure Boot enabled.

## After installation

---

After installing AnduinOS, you may need to [Install Drivers](./Install-Drivers.md).
