# JetBrains Rider

JetBrains Rider is a cross-platform .NET IDE based on the IntelliJ platform and ReSharper.

To install JetBrains Rider on AnduinOS, you can run the following commands:

<!-- The link needs to be updated regularly. -->

```bash
url=https://download.jetbrains.com/rider/JetBrains.Rider-2024.3.2.tar.gz
wget -O /tmp/rider.tar.gz $url
sudo tar -xzf /tmp/rider.tar.gz -C /opt
sudo rm /opt/rider-old-backup -rf
sudo mv /opt/rider /opt/rider-old-backup || true
sudo mv /opt/JetBrains\ Rider-2024.2.6 /opt/rider
sudo chown -R $USER:$USER /opt/rider
rm /tmp/rider.tar.gz
echo "[Desktop Entry]
Name=JetBrains Rider
Comment=Integrated Development Environment
Exec=/opt/rider/bin/rider.sh
Icon=/opt/rider/bin/rider.svg
Terminal=false
Type=Application
Categories=Development;IDE;" | sudo tee /usr/share/applications/jetbrains-rider.desktop
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.jetbrains.com/rider/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
