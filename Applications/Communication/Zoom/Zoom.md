# Zoom

Zoom is a video conferencing software that allows you to host and join video calls. It is widely used for remote work, online classes, and virtual meetings. Zoom offers features such as screen sharing, recording, and chat, making it a versatile tool for communication and collaboration.

## Flatpak install (Recommended)

You can install Code::Blocks via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub us.zoom.Zoom
```

## System install

To install Zoom on AnduinOS, you can run the following commands in the terminal:

```bash
wget https://zoom.us/client/latest/zoom_amd64.deb -O zoom.deb
sudo apt install ./zoom.deb -y
rm zoom.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
