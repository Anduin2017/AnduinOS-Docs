# Opera

Opera is a web browser developed by Opera Software. The latest version is available for Microsoft Windows, OS X, and Linux operating systems.

To install Opera on AnduinOS, you can run the following commands:

```bash
wget -qO- https://deb.opera.com/archive.key | gpg --dearmor | sudo dd of=/usr/share/keyrings/opera-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/opera-browser.gpg] https://deb.opera.com/opera-stable/ stable non-free" | sudo dd of=/etc/apt/sources.list.d/opera-archive.list
sudo apt update
sudo apt install opera-stable -y
```
