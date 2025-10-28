# Yes-Play-Music

Yes-Play-Music is a beautiful third-party Netease Cloud Music client maintained by the community.

## Flatpak install

You can install Yes-Play-Music via Flatpak by running the following commands in your terminal:

!!! warning "This source is not official"

    As you can see from [this submission](https://github.com/flathub/io.github.qier222.YesPlayMusic/pull/45), the source is a fork version, not the official version.

```bash
flatpak install flathub io.github.qier222.YesPlayMusic
```

## System install (manual)

To Install Yes-Play-Music on AnduinOS, first download a deb package from [here](https://github.com/qier222/YesPlayMusic/releases). Then you can install it with `apt`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://github.com/qier222/YesPlayMusic/releases/download/v0.4.10/yesplaymusic_0.4.10_amd64.deb -O yesplaymusic.deb
sudo apt install ./yesplaymusic.deb -y
rm yesplaymusic.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://github.com/qier222/YesPlayMusic/releases) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Third-party repository

If you want to automatically update via `sudo apt upgrade`, you can try adding [wcbing APT Repo](https://github.com/wcbing/wcbing-apt-repo). This is a third-party software repository that is updated more timely. 

If you have not added it before, please follow the steps below:

```sh
curl -O https://packages.wcbing.top/deb/wcbing-keyring.deb
sudo apt install ./wcbing-keyring.deb
rm ./wcbing-keyring.deb
```

Then, you can install via apt:

```sh
sudo apt update
sudo apt install yesplaymusic
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.
