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

### 5. Switch the source (optional)

For some regions, like China mainland, you may want to switch the source to a mirror. You can do this by running:

```bash title="Switch Flathub Source to a Mirror"
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
```

To view current mirror you are using, run:

```bash title="View Current Flathub Mirror"
flatpak remotes --columns=name,url
```

The output will be similar to:

```
Name    URL
flathub https://mirror.sjtu.edu.cn/flathub
```

To revert to the original Flathub source, run:

```bash title="Revert to Original Flathub Source"
sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo
```

To refresh the list of apps, run:

```bash title="Refresh Flathub Apps"
flatpak remote-ls flathub
```
