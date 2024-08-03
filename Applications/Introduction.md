# Application Store

This is the official application store for AnduinOS. Here you can find the most popular applications for AnduinOS.

!!! note "Start exploring now!"

    To get started, pick the app from the menu on the left!

---

## How to install applications on AnduinOS

AnduinOS support the same software installation methods as Debian.

While we provide an official way to install some applications, you can also install applications from the official Debian repository or other third-party repositories.

Before continuing, you need to know how to open terminal on AnduinOS.

## How to paste the commands into the terminal

To open the terminal on AnduinOS, you can press `Ctrl + Alt + T` or search for `Terminal` in the application menu.

Once you have opened the terminal, you can follow the instructions below to install applications on AnduinOS.

You need to copy the commands and paste them into the terminal. To paste the copied commands into the terminal, you can press `Ctrl + Shift + V`.

* If the terminal asks for your confirmation, you need to type `Y` and press `Enter`.
* If the terminal asks for your password, you need to enter your password and press `Enter`.

## Before installing applications

Before starting, we strongly recommend installing the following applications first:

```bash title="Install the necessary tools"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common wget gnupg -y
```

This command will install the necessary tools to install applications from the official Debian repository or other third-party repositories.

## Install applications from the apt repository

To install applications from the apt repository, you can run:

```bash
sudo apt update
sudo apt install <package-name>
```

For example, to install `htop`, you can run:

```bash
sudo apt update
sudo apt install htop
```

To learn more about apt, please read the [Use apt to manage packages](../Skills/System-Management/Use-APT-to-manage-packages.md) guide.

## Install applications from the .deb package

To install applications from the .deb package, you need to download the .deb package from the official website. For example:

```bash
cd ~
wget https://updates.insomnia.rest/downloads/ubuntu/latest -O insomnia.deb
```

Then, you can install the .deb package by running:

```bash
sudo dpkg -i insomnia.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

!!! note "Setup apps upgrade automatically"

    If you want to setup the application to upgrade automatically, you can follow the instructions [here](../Install/Update-Your-System.md)
