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

!!! warning "Adjust Secure Boot to trust 3rd party OS"

    By default, your virtual machine may have Secure Boot enabled, which can prevent the installation of 3rd party operating systems. You may need to adjust the Secure Boot settings in the virtual machine's BIOS to trust 3rd party operating systems.

    Sample for virtual manager:

    ```xml title="Sample for virtual manager"
    <os firmware="efi">
        <type arch="x86_64" machine="pc-q35-6.2">hvm</type>
        <firmware>
        <feature enabled="yes" name="enrolled-keys"/>
        <feature enabled="yes" name="secure-boot"/>
        </firmware>
        <boot dev="hd"/>
    </os>
    ```

---

## Bare-mental Installation - Make a USB installer

First, download the latest release of AnduinOS from the releases page.

Then, create a bootable USB drive with the downloaded ISO file. Obviously, you need a USB drive with at least 4GB of storage.

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

!!! warning "Data Loss!"

    This command will erase all data on the USB drive. Make sure to back up your data before running this command.

Then, boot the computer from the USB drive and follow the on-screen instructions to install AnduinOS.

!!! warning "Adjust Secure boot settings in your BIOS!"

    If you are using a UEFI system, by default it may only trust Microsoft-signed operating systems. In this case, you may need to adjust the Secure Boot settings in your BIOS to trust 3rd party operating systems. Please refer to your system's documentation for instructions on how to do this.

    ![Adjust secure boot settings](./seboot.png)

## After installation

---

After installing AnduinOS, you may need to [Install Drivers](./Install-Drivers.md).
