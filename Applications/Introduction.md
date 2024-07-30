# How to install applications on AnduinOS

AnduinOS support the same software installation methods as Debian.

While we provide an official way to install some applications, you can also install applications from the official Debian repository or other third-party repositories.

Before continuing, you need to know how to open terminal on AnduinOS.

## Open the terminal

To open the terminal on AnduinOS, you can press `Ctrl + Alt + T` or search for `Terminal` in the application menu.

Once you have opened the terminal, you can follow the instructions below to install applications on AnduinOS.

You need to copy the commands and paste them into the terminal. To paste the copied commands into the terminal, you can press `Ctrl + Shift + V`.

* If the terminal asks for your confirmation, you need to type `Y` and press `Enter`.
* If the terminal asks for your password, you need to enter your password and press `Enter`.

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
wget https://updates.insomnia.rest/downloads/ubuntu/latest -O insomnia.deb
```

Then, you can install the .deb package by running:

```bash
sudo dpkg -i insomnia.deb
```

Or, you can install the .deb package with `apt` by running:

```bash
sudo apt install ./insomnia.deb
```
