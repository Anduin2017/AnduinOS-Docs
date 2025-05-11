# QQ Music

QQ Music is a music player and streaming service developed by Tencent. It is available on Windows, macOS, Android, and iOS. QQ Music is one of the most popular music streaming services in China.

<!-- The link needs to be updated regularly. -->

```sh
curl -o qqmusic.deb https://dldir1.qq.com/music/clntupate/linux/qqmusic_1.1.7_amd64.deb
sudo apt install -y ./qqmusic.deb
rm qq.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://y.qq.com/download/download.html) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Wine

There is also a version of QQ Music available for Linux via Wine. This version is not officially supported by Tencent, but it is maintained by the community. It is available in the Deepin Wine repository.

To install QQ Music on AnduinOS, you can run:

```bash
wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
sudo apt install com.qq.music.deepin
```
