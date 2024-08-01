# QQ

Tencent QQ (Chinese: 腾讯QQ), also known as QQ, is an instant messaging software service and web portal developed by the Chinese technology company Tencent. QQ offers services that provide online social games, music, shopping, microblogging, movies, and group and voice chat software.

To Install QQ on AnduinOS, first download a deb package form [here](https://im.qq.com/linuxqq/index.shtml). Then you can install it with `dpkg`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.10_240715_amd64_01.deb -O qq.deb
sudo dpkg -i qq.deb
rm qq.deb
```

!!! warning

    The link above may be outdated. Please visit the [official website](https://im.qq.com/linuxqq/index.shtml) to get the latest version.
