# WPS Office

WPS Office is a suite of office software developed by Kingsoft Office. It is available for Windows, Linux, Android, and iOS.

To install WPS Office on AnduinOS, you can run:

<!-- The link needs to be updated regularly. -->

```bash
wget https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11723/wps-office_11.1.0.11723.XA_amd64.deb -O wps.deb
sudo dpkg -i wps.deb
rm wps.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.wps.com/office/linux/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
