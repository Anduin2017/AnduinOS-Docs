# Microsoft Edge

Microsoft Edge is a web browser developed by Microsoft. It was first released for Windows 10 and Xbox One in 2015, and later for Android and iOS in 2017. It is the default web browser on Windows 10 and is designed to be fast, secure, and easy to use.

To install Microsoft Edge on AnduinOS, you can run:

```bash
wget https://go.microsoft.com/fwlink?linkid=2149051 -O microsoft-edge-stable.deb
sudo dpkg -i microsoft-edge-stable.deb
sudo apt install --fix-broken
rm microsoft-edge-stable.deb
```

## Set Microsoft Edge as the default web browser

To set Microsoft Edge as the default web browser on AnduinOS, you can run:

```bash
xdg-mime default microsoft-edge.desktop x-scheme-handler/http
xdg-mime default microsoft-edge.desktop text/html
xdg-mime default microsoft-edge.desktop application/xhtml+xml
xdg-mime default microsoft-edge.desktop x-scheme-handler/https
```
