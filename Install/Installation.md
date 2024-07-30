# AnduinOS Installation Guide

## Download AnduinOS

Before installing AnduinOS, you need to download the ISO file from the releases page.

[Download AnduinOS (ISO)](https://github.com/Anduin2017/AnduinOS/releases)

## Virtual Machine Installation

First, download AnduinOS from releases page.

Then, create a new virtual machine with any virtualization software (e.g. VirtualBox, VMware, etc.) and attach the downloaded ISO file to the virtual machine.

Finally, boot the virtual machine and follow the on-screen instructions to install AnduinOS.

> For UEFI boot, please make sure to disable secure boot in the virtual machine settings.

## Bare-mental Installation - Make a USB installer

First, download the latest release of AnduinOS from the releases page.

If you are using a Windows machine, you can use Rufus to create a bootable USB drive. If you are using a Linux machine, you can use the `dd` command.

```shell
sudo dd if=./AnduinOS-jammy-1.0.0-2407181704.iso of=<device> status=progress oflag=sync bs=4M
```

Then, boot the computer from the USB drive and follow the on-screen instructions to install AnduinOS.
