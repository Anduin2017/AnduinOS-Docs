# DBeaver

DBeaver is a SQL client software application and a database administration tool. The community edition (CE) of DBeaver is a free and open source software that is distributed under the Apache License.

To install DBeaver on AnduinOS, first download a deb package from [here](https://github.com/dbeaver/dbeaver/releases). Then you can install it with `dpkg`:

<!-- The link needs to be updated regularly. -->

```bash
cd ~
wget https://github.com/dbeaver/dbeaver/releases/download/24.1.3/dbeaver-ce_24.1.3_amd64.deb -O dbeaver.deb
sudo dpkg -i dbeaver.deb
rm dbeaver.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://github.com/dbeaver/dbeaver/releases) to get the latest version.

Get the newest download link without open browser: (with API rate limit)

```bash
curl -s https://api.github.com/repos/dbeaver/dbeaver/releases/latest | grep browser_download_url | grep amd64.deb | cut -d '"' -f 4
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
