# JetBrains Rider

JetBrains Rider is a cross-platform .NET IDE based on the IntelliJ platform and ReSharper.

To install JetBrains Rider on AnduinOS, you can run the following commands:

<!-- The link needs to be updated regularly. -->

```bash
url=https://download.jetbrains.com/rider/JetBrains.Rider-2024.1.4.tar.gz
wget -O /tmp/rider.tar.gz $url
#unzip /tmp/rider.tar.gz -d /opt
sudo tar -xzf /tmp/rider.tar.gz -C /opt
sudo chown -R $USER:$USER /opt/JetBrains\ Rider-2024.1.4
sudo mv /opt/JetBrains\ Rider-2024.1.4 /opt/rider
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