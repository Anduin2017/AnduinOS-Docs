# Microsoft Edge

Microsoft Edge is a web browser developed by Microsoft. It was first released for Windows 10 and Xbox One in 2015, and later for Android and iOS in 2017. It is the default web browser on Windows 10 and is designed to be fast, secure, and easy to use.

To install Microsoft Edge on AnduinOS, you can run:

```bash title="Install Microsoft Edge"
wget https://go.microsoft.com/fwlink?linkid=2149051 -O microsoft-edge-stable.deb
sudo dpkg -i microsoft-edge-stable.deb
sudo apt install --fix-broken
rm microsoft-edge-stable.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Set Microsoft Edge as the default web browser

To set Microsoft Edge as the default web browser on AnduinOS, you can run:

```bash title="Set Microsoft Edge as the default web browser"
xdg-mime default microsoft-edge.desktop x-scheme-handler/http
xdg-mime default microsoft-edge.desktop text/html
xdg-mime default microsoft-edge.desktop application/xhtml+xml
xdg-mime default microsoft-edge.desktop x-scheme-handler/https
```
