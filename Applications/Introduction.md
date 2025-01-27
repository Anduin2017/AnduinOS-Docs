# Application Store

This is the official application store for AnduinOS. Here you can find the most popular applications for AnduinOS.

!!! note "Start exploring now!"

    To get started, pick the app from the menu on the left!

!!! warning "Disclaimer - No warranty"

    The programs included with the AnduinOS are free software; the exact distribution terms for each program are described in the individual files in `/usr/share/doc/*/copyright`.

    AnduinOS comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.

    The applications mentioned in this store might NOT be officially supported by AnduinOS! Please refer to the official website of the application for support.

    The applications mentioned in this store might NOT be open-source! Please refer to the license of the application for more information.

## How to install applications on AnduinOS

AnduinOS support the same software installation methods as Debian.

While we provide an official way to install some applications, you can also install applications from the official Debian repository or other third-party repositories.

Before continuing, you need to know how to open terminal on AnduinOS.

??? Tip "Why a native store is not pre-installed?"

    The decision not to include a pre-installed software store in AnduinOS stems from several key considerations.

    Traditional package management systems each present unique challenges. For instance, Nix, while powerful with its functional approach, can be daunting for the average user to navigate. Arch's AUR, despite its flexibility, is often criticized for its chaotic and hard-to-manage nature. Ubuntu and Debian's `apt` package manager is reliable, but resolving package conflicts can be particularly challenging. Meanwhile, newer industry trends favor solutions like Snap, AppImage, and Flatpak. We believe it makes sense to rely on `apt` for managing core system components while utilizing modern solutions such as Flatpak, Docker, AppImage, or Snap for user-installed graphical applications.

    It’s also evident that preferences for software management vary widely among users today. Some prefer native package managers like `apt` or `dnf`, others appreciate the extensibility of AUR, while many are drawn to newer approaches like Nix, Flatpak, Docker, AppImage, or Snap. The guiding principle for AnduinOS's pre-installed content is straightforward: if it’s not certain that all users need something, it won’t be pre-installed. AnduinOS primarily targets professional users who are proficient in managing their system's software packages, and for most, `apt` alone suffices. Furthermore, the Linux application store ecosystem is highly fragmented, often relying on different underlying package management solutions, such as `dpkg`, AppImage, Flatpak, or Docker.

    Currently, AnduinOS lacks a specific development direction or distinguishing focus. Therefore, apart from `apt`, it doesn’t come pre-configured with any additional software management systems or stores. This design provides flexibility, allowing users to adopt the solutions that best suit their needs. For those seeking a modern graphical app store experience, Flatpak combined with Flathub is highly recommended.

    Additionally, many software license agreements explicitly state that unauthorized distribution is illegal. If we operate our own app store, such software that we lack the rights to distribute cannot be included in the store. We cannot take on this legal risk. For example: Google Chrome, Skype, Zoom, WhatsApp, ElasticSearch, Minecraft, Steam, Epic Store, EA Origin, etc. Therefore, the best option we can provide is to guide users on how to install these applications via their official channels on Linux and organize one-click installation methods through the official channels.

    By omitting a pre-installed software store, AnduinOS empowers users to choose the option that aligns best with their workflow and preferences.

To install a native App Store, please [click here](../Install/Install-An-App-Store.md).

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
sudo apt install ./insomnia.deb -y
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

!!! note "Setup apps upgrade automatically"

    If you want to setup the application to upgrade automatically, you can follow the instructions [here](../Install/Update-Your-System.md)
