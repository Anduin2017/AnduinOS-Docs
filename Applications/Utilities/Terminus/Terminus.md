# Terminus

Terminus is a cross-platform terminal emulator that is available for Windows, macOS, and Linux. It is a modern terminal emulator that is designed to be easy to use and highly customizable. It is built on top of Electron, which is a popular framework for building cross-platform desktop applications using web technologies like HTML, CSS, and JavaScript.

## Flatpak install (Recommended)

You can install Terminus via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub com.termius.Termius
```

## System install

To install Terminus on AnduinOS, you can run:

```bash
link=https://www.termius.com/download/linux/Termius.deb
wget $link -O terminus.deb
sudo apt install ./terminus.deb -y
rm terminus.deb
```
