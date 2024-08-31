# Discord

Discord is a free voice, video, and text chat app for gamers. It is available on Windows, macOS, iOS, Android, and Linux.

To install Discord on AnduinOS, you can run:

```bash
link="https://discord.com/api/download?platform=linux&format=deb"
wget -O discord.deb $link
sudo apt install ./discord.deb
sudo apt install --fix-broken -y
rm discord.deb
```
