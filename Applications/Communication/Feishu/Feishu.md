# Feishu

## Flatpak install (Recommended)

You can install Feishu via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub cn.feishu.Feishu
```

## System install

ByteDance Feishu is a communication and collaboration tool. It is a competitor to Slack and Microsoft Teams.

To Install Feishu on AnduinOS, first download a deb package form [here](https://www.feishu.cn/download). Then you can install it with `apt`:

```bash
api=https://www.feishu.cn/api/package_info?platform=10
download_link=$(curl -s $api | jq -r '.data.download_link')
wget $download_link -O Feishu.deb
sudo apt install ./Feishu.deb -y
rm Feishu.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.feishu.cn/download) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
