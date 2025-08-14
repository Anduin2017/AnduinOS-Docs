# WPS Office

WPS Office is a suite of office software developed by Kingsoft Office. It is available for Windows, Linux, Android, and iOS.

To install WPS Office on AnduinOS, you can run:

<!-- The link needs to be updated regularly. -->

```bash
wget https://mirrors.163.com/ubuntukylin/pool/partner/wps-office_11.1.0.11723_amd64.deb -O wps.deb
sudo apt install ./wps.deb -y
rm wps.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.wps.com/office/linux/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Third-party repository

If you want to automatically update via `sudo apt upgrade`, you can try adding [wcbing APT Repo](https://packages.wcbing.top/deb/). This is a third-party software repository that is updated more timely. 

If you have not added it before, please follow the steps below:

```sh
curl -O https://packages.wcbing.top/deb/wcbing-keyring.deb
sudo apt install ./wcbing-keyring.deb
rm ./wcbing-keyring.deb
```

Then, you can install via apt:

```sh
sudo apt update
sudo apt install wps-office
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.


## Fix the `missing fonts` issue

WPS may alert you that some fonts are missing. To fix this, you can install the fonts via this [GitHub Repo https://github.com/dv-anomaly/ttf-wps-fonts](https://github.com/dv-anomaly/ttf-wps-fonts).
