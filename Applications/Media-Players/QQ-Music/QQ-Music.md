# QQ Music

QQ Music is a music player and streaming service developed by Tencent. It is available on Windows, macOS, Android, and iOS. QQ Music is one of the most popular music streaming services in China.

## Flatpak install

!!! warning "The QQ Music on Flatpak may be outdated"

    This repository maintainer is inactive, so it may be outdated sometime.

You can install QQ Music via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub com.qq.QQmusic
```

## System install (manual)

To install QQ Music on AnduinOS, you can run:

<!-- The link needs to be updated regularly. -->

```sh
curl -Lo qqmusic.deb https://c.y.qq.com/cgi-bin/file_redirect.fcg?bid=dldir&file=ecosfile_plink%2Fmusic_clntupate%2Flinux%2Fother%2Fqqmusic_1.1.8_amd64.deb&sign=1-d1ca4d5c5a8369b26af88e881ba3ac544066a899dcaea29778b35c9f648e6fee-68cb7c1c
sudo apt install -y ./qqmusic.deb
rm qq.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://y.qq.com/download/download.html) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Third-party repository

If you want to automatically update via `sudo apt upgrade`, you can try adding [wcbing APT Repo](https://packages.wcbing.top/deb/). This is a third-party software repository that is updated more timely. 

If you have not added it before, please follow the steps below:

```sh
curl -O https://packages.wcbing.top/deb/wcbing-keyring.deb
sudo apt install ./wcbing-keyring.deb
rm ./wcbing-keyring.deb
```

Then, you can install via apt:

```sh
sudo apt update
sudo apt install qqmusic
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.

## Wine

There is also a version of QQ Music available for Linux via Wine. This version is not officially supported by Tencent, but it is maintained by the community. It is available in the Deepin Wine repository.

To install QQ Music on AnduinOS, you can run:

```bash
wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
sudo apt install com.qq.music.deepin
```
