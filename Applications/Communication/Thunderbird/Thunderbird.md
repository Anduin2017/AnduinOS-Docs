# Thunderbird Mail

!!! tip "AnduinOS Verified App - Open Source"

    Thunderbird is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Thunderbird is a free email application that’s easy to set up and customize - and it’s loaded with great features!

## Flatpak install (Recommended)

You can install Thunderbird Mail via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub org.mozilla.Thunderbird
```

## System install

To install Thunderbird on AnduinOS, you can run the following commands:

```bash
sudo add-apt-repository -y ppa:mozillateam/ppa -n > /dev/null 2>&1
echo -e '\nPackage: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1002' | sudo tee /etc/apt/preferences.d/mozilla-ppa
sudo apt update
sudo apt install thunderbird
```
