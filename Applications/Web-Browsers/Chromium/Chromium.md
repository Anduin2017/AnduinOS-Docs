# Chromium

Chromium is an open-source web browser project started by Google, to provide the source code for the proprietary Google Chrome browser. The two browsers share the majority of code and features, though there are some minor differences in features and they have different licensing.

To install Chromium on AnduinOS, you can run:

```bash
sudo add-apt-repository ppa:saiarcot895/chromium-beta
sudo apt-get update
sudo apt-get install chromium-browser
```

!!! note "Non-official PPA"

    The `ppa:saiarcot895/chromium-beta` PPA is not an official PPA. This may bring some security risks. And the Chromium browser may not be the latest version.
    
    Use it at your own risk.

## Set Chromium as the default web browser

To set Chromium as the default web browser on AnduinOS, you can run:

```bash title="Set MChromium as the default web browser"
xdg-mime default chromium-browser.desktop x-scheme-handler/http
xdg-mime default chromium-browser.desktop text/html
xdg-mime default chromium-browser.desktop application/xhtml+xml
xdg-mime default chromium-browser.desktop x-scheme-handler/https
```
