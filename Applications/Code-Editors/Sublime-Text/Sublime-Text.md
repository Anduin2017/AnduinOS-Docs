# Sublime Text

!!! tip "AnduinOS Verified App"

    Sublime Text is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Sublime Text is a sophisticated text editor for code, markup and prose. You'll love the slick user interface, extraordinary features and amazing performance.

## Flatpak install (Not recommended)

You can install Sublime Text via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub com.sublimetext.three
```

## System install

To install Sublime Text on AnduinOS, you can run:

```bash
sudo apt install apt-transport-https
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text
```
