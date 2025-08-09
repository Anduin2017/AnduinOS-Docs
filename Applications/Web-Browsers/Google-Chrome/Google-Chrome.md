# Google Chrome

!!! tip "AnduinOS Verified App"

    Google Chrome is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Google Chrome is a cross-platform web browser developed by Google. It was first released in 2008 for Microsoft Windows and later ported to Linux, macOS, iOS, and Android. The browser is based on the open-source Chromium project, which is also developed by Google.

To install Google Chrome on AnduinOS, you can run:

```bash title="Install Google Chrome"
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable
```

Or you can install the deb file of Google Chrome:

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
sudo apt install ./google-chrome.deb -y
rm google-chrome.deb
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

## Fix Wayland issue

If you are using Wayland with fractional scaling, you may encounter an issue when running Google Chrome. Google Chrome may display with fuzzy text and blurry images.

To fix the issue, you can open Chrome and enter the following URL in the address bar:

```text
chrome://flags/#ozone-platform-hint
```

Then, select `Auto` from the dropdown list and restart Chrome.

You need to quit all Chrome windows and restart Chrome to apply the changes.

## Fix iBus typing issue

If you are using iBus as the input method framework, you may encounter an issue when typing in Google Chrome. The issue may cause you unable to type in the address bar or text fields in Chrome.

To fix the issue, you can edit the `/usr/share/applications/google-chrome.desktop` file and edit the `Exec` line as follows:

```text
Exec=/usr/bin/google-chrome-stable --gtk-version=4 %U
```

Or you can directly run:

```bash title="Fix iBus typing issue"
# Replace 'Exec=/usr/bin/google-chrome-stable' with 'Exec=/usr/bin/google-chrome-stable --gtk-version=4' in the google-chrome.desktop file
sudo sed -i 's|Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable --gtk-version=4|' /usr/share/applications/google-chrome.desktop
```

You need to log out and log back in to apply the changes.
