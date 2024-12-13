# Obisidian

Obisidian is a note-taking app that allows you to create and manage notes in a simple and efficient way. It is designed to help you organize your thoughts and ideas, and keep track of important information. With Obisidian, you can easily create new notes, link them together, and search for specific information. It also offers a range of features to help you customize your notes, such as formatting options, tags, and themes. Overall, Obisidian is a powerful tool for anyone looking to improve their note-taking and organization skills.

To install Obisidian on AnduinOS, follow these steps:

```bash title="Install Obisidian"
link=https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/obsidian_1.7.7_amd64.deb
wget $link -O /tmp/obsidian.deb
sudo dpkg -i /tmp/obsidian.deb
sudo apt install --fix-broken -y
rm /tmp/obsidian.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.wps.com/office/linux/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
