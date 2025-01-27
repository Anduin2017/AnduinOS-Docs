# Obsidian

Obsidian is a powerful knowledge base that works on top of a local folder of plain text Markdown files.

To install Obsidian on AnduinOS, follow these steps:

```bash title="Install Obsidian"
link=https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/obsidian_1.7.7_amd64.deb
wget $link -O /tmp/obsidian.deb
sudo apt install /tmp/obsidian.deb -y
rm /tmp/obsidian.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://obsidian.md/download) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
