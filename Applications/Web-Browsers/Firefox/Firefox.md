# Firefox

Firefox is a free and open-source web browser developed by the Mozilla Foundation. It is available for Windows, macOS, Linux, and Android.

By default, AnduinOS is shipped with Firefox as the default web browser.

However, if you want to install Firefox, you can do so by running the following command:

```bash
sudo add-apt-repository -y ppa:mozillateam/ppa -n > /dev/null 2>&1
echo -e '\nPackage: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1002' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update
sudo apt install firefox
```
