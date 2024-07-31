# Microsoft Edge

Microsoft Edge is a web browser developed by Microsoft. It was first released for Windows 10 and Xbox One in 2015, and later for Android and iOS in 2017. It is the default web browser on Windows 10 and is designed to be fast, secure, and easy to use.

To install Microsoft Edge on AnduinOS, you can follow the steps below:

1. Download the Microsoft Edge .deb package from the official website: [Microsoft Edge Download](https://www.microsoft.com/en-us/edge)
2. Open a terminal and navigate to the directory where the .deb package is located.
3. Run the following command to install Microsoft Edge:

```bash
sudo dpkg -i microsoft-edge-stable.deb
sudo apt install --fix-broken
rm microsoft-edge-stable.deb
```
