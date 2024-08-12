# Yes-Play-Music

Yes-Play-Music is a beautiful third-party Netease Cloud Music client maintained by the community.

To Install Yes-Play-Music on AnduinOS, first download a deb package from [here](https://github.com/qier222/YesPlayMusic/releases). Then you can install it with `dpkg`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://github.com/qier222/YesPlayMusic/releases/download/v0.4.8-2/yesplaymusic_0.4.8_amd64.deb -O yesplaymusic.deb
sudo dpkg -i yesplaymusic.deb
rm yesplaymusic.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://github.com/qier222/YesPlayMusic/releases) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
