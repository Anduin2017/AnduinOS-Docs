# QQ

Tencent QQ (Chinese: 腾讯QQ), also known as QQ, is an instant messaging software service and web portal developed by the Chinese technology company Tencent. QQ offers services that provide online social games, music, shopping, microblogging, movies, and group and voice chat software.

To Install QQ on AnduinOS, first download a deb package form [here](https://im.qq.com/linuxqq/index.shtml). Then you can install it with `dpkg`:

```bash
# Always download the newest package from official website.
# wget https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.10_240715_amd64_01.deb
sudo dpkg -i QQ_3.2.10_240715_amd64_01.deb
```

If you would like to make QQ update itself automatically and are also using [flatpak](https://flatpak.org/), then you can install QQ from [flathub](https://flathub.org/apps/com.qq.QQ).

**Note that this wrapper is not verified by, affiliated with, or supported by Tencent.**

```bash
flatpak install flathub com.qq.QQ
```
