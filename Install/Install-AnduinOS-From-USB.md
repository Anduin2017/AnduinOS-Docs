# Install AnduinOS by Booting from a USB Drive

---

After burning the AnduinOS ISO file to a USB drive in the [previous step](./Burn-A-USB-Stick.md), you can boot your computer from the USB drive to install AnduinOS. This guide will show you how to boot from a USB drive on different systems.

## Turn off Secure Boot

!!! warning "Turn off Secure Boot for UEFI systems"

    If you are using a UEFI system, by default it may enabled Secure Boot, which can prevent the installation of 3rd party operating systems. You may need to disable Secure Boot in the BIOS settings to install AnduinOS.

    While AnduinOS's installer ISO doesn't support Secure Boot, the installed system does. You may need to disable Secure Boot in the BIOS settings only to install AnduinOS. And you can re-enable Secure Boot after the installation.

To turn off Secure Boot, you need to enter BIOS settings first. The key to enter BIOS settings varies depending on the manufacturer of your computer. Common keys include `F2`, `F10`, `Volume up + Power` or `Del`. You can usually see the key to enter BIOS settings on the boot screen when you start your computer.

Boot your computer, press `F2` or the key to enter BIOS settings, and then find the Secure Boot option in the BIOS settings. Disable Secure Boot and save the changes. Then you can boot your computer from the USB drive.

## Boot from USB

The key to enter the boot devices menu varies depending on the manufacturer of your computer. Common keys include `F12`, `F11`, `Esc`, `F10`, or `Volume down + Power`.

Boot your computer, press the key to enter the boot devices menu, and then select the USB drive from the boot menu. Your computer will boot from the USB drive, and you will see the AnduinOS installer screen.

## Select between Try AnduinOS and Install AnduinOS

After booting from the USB drive, you will see the AnduinOS installer screen. You can choose between `Try AnduinOS` and `Install AnduinOS`.

- `Try AnduinOS`: This option allows you to try AnduinOS without installing it. You can explore the system and see if it works well on your computer.
- `Install AnduinOS`: This option will start the installation process. You can follow the on-screen instructions to install AnduinOS on your computer.

Choose the option that suits your needs, and follow the on-screen instructions to install AnduinOS on your computer.

## Installation Process

The installation process will guide you through the following steps:

1. **Select Language**: Choose the language you want to use during the installation process.
2. **Select Keyboard Layout**: Choose the keyboard layout you want to use.
3. **Updates and Other Software**: Choose whether you want to install updates and third-party software during the installation process.
4. **Setup Disk**: Choose the disk where you want to install AnduinOS. You can also choose to encrypt the disk with LVM and LUKS2.
5. **Location**: Choose your location to set the time zone.
6. **User Information**: Enter your name, username, and password for the new user account.
7. **Installation**: The installation process will start, and you can see the progress on the screen.
8. **Complete**: Once the installation is complete, you will be prompted to restart your computer.
