# Obsidian

Obsidian is a powerful knowledge base that works on top of a local folder of plain text Markdown files.

## Flatpak install (Recommended)

You can install Obsidian via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub md.obsidian.Obsidian
```

## System install

To install Obsidian on AnduinOS, follow these steps:

```bash title="Install Obsidian"
link=https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.10/obsidian_1.8.10_amd64.deb
wget $link -O /tmp/obsidian.deb
sudo apt install /tmp/obsidian.deb -y
rm /tmp/obsidian.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://obsidian.md/download) to get the latest version.

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
sudo apt install obsidian
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.

