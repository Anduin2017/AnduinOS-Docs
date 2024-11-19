# Install Flatpak and Flathub as a Software Store

Follow these simple steps to start using Flatpak as a Software Store on AnduinOS.

## 1. Install Flatpak

To install Flatpak on AnduinOS, simply run:

```bash
sudo apt install flatpak
```

## 2. Install the Software Flatpak plugin

The Flatpak plugin for the Software app makes it possible to install apps without needing the command line. To install, run:

```bash
sudo apt install gnome-software-plugin-flatpak
```

## 3. Add the Flathub repository

Flathub is the best place to get Flatpak apps. To enable it, run:

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

### 4. Restart

To complete setup, restart your system. Now all you have to do is [install some apps](https://flathub.org/)!
