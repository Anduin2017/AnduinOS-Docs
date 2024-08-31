# Discord

Discord is a free voice, video, and text chat app for gamers. It is available on Windows, macOS, iOS, Android, and Linux.

To install Discord on AnduinOS, you can run:

```bash
link="https://discord.com/api/download?platform=linux&format=deb"
wget -O discord.deb $link
sudo dpkg -i discord.deb
sudo apt install --fix-broken -y
rm discord.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
