# Motrix

Motrix is a full-featured download manager that supports downloading HTTP, FTP, BitTorrent, Magnet, Baidu Net Disk and more. It is available for Windows, macOS and Linux.

To install Motrix on AnduinOS, you can run:

<!-- The link needs to be updated regularly. -->

```bash
wget https://dl.motrix.app/release/Motrix_1.8.19_amd64.deb
sudo dpkg -i Motrix_1.8.19_amd64.deb
rm Motrix_1.8.19_amd64.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://motrix.app/download) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
