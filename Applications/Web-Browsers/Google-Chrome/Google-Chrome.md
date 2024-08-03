# Google Chrome

Google Chrome is a cross-platform web browser developed by Google. It was first released in 2008 for Microsoft Windows and later ported to Linux, macOS, iOS, and Android. The browser is based on the open-source Chromium project, which is also developed by Google.

To install Google Chrome on AnduinOS, you can run:

```bash title="Install Google Chrome"
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable
```

!!! note "Uninstall Firefox"

    After installing Google Chrome, you may want to uninstall the default web browser, Firefox. To uninstall Firefox, you can run:

    ```bash
    sudo apt autoremove firefox
    ```

## Set Google Chrome as the default web browser

To set Google Chrome as the default web browser on AnduinOS, you can run:

```bash title="Set Google Chrome as the default web browser"
xdg-mime default google-chrome.desktop x-scheme-handler/http
xdg-mime default google-chrome.desktop text/html
xdg-mime default google-chrome.desktop application/xhtml+xml
xdg-mime default google-chrome.desktop x-scheme-handler/https
```
