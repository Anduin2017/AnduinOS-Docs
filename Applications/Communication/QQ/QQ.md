# QQ

Tencent QQ (Chinese: 腾讯QQ), also known as QQ, is an instant messaging software service and web portal developed by the Chinese technology company Tencent. QQ offers services that provide online social games, music, shopping, microblogging, movies, and group and voice chat software.

To Install QQ on AnduinOS, first download a deb package form [here](https://im.qq.com/linuxqq/index.shtml). Then you can install it with `apt`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://dldir1v6.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.18_250724_amd64_01.deb -O qq.deb
sudo apt install ./qq.deb -y
rm qq.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://im.qq.com/linuxqq/index.shtml) to get the latest version.

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
sudo apt install linuxqq
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.

