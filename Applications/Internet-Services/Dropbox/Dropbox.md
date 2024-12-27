# Dropbox

Dropbox is a file hosting service that offers cloud storage, file synchronization, personal cloud, and client software.

To install Dropbox on AnduinOS, you can run:

```bash
url=https://linux.dropbox.com/packages/ubuntu/dropbox_2024.04.17_amd64.deb
wget $url -O dropbox.deb
sudo dpkg -i dropbox.deb
sudo apt install --fix-broken -y
rm dropbox.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.dropbox.com/install-linux) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
