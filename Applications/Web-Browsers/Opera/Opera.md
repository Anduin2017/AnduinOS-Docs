# Opera

Opera is a web browser developed by Opera Software. The latest version is available for Microsoft Windows, OS X, and Linux operating systems.

To install Opera on AnduinOS, you can run the following commands:

```bash
sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
wget -qO - https://deb.opera.com/archive.key | sudo apt-key add -
sudo apt update
sudo apt install opera-stable -y
```
