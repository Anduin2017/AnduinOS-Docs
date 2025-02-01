# JetBrains Rider

JetBrains Rider is a cross-platform .NET IDE based on the IntelliJ platform and ReSharper.

To install JetBrains Rider on AnduinOS, you can run the following commands:

<!-- The link needs to be updated regularly. -->

```bash
url="https://download.jetbrains.com/rider/JetBrains.Rider-2024.3.4.tar.gz"
wget -O /tmp/rider.tar.gz "$url"
sudo tar -xzf /tmp/rider.tar.gz -C /opt
sudo rm -rf /opt/rider-old-backup
sudo mv /opt/rider /opt/rider-old-backup || true
sudo mv /opt/JetBrains\ Rider-2024.3.4 /opt/rider
sudo chown -R "$USER":"$USER" /opt/rider
rm /tmp/rider.tar.gz

sudo tee /usr/share/applications/jetbrains-rider.desktop > /dev/null <<'EOF'
[Desktop Entry]
Name=JetBrains Rider
Comment=Integrated Development Environment
Exec=/opt/rider/bin/rider.sh %f
Icon=/opt/rider/bin/rider.svg
Terminal=false
Type=Application
Categories=Development;IDE;
MimeType=text/x-sln;
EOF

sudo update-desktop-database /usr/share/applications

sudo tee /usr/share/mime/packages/sln.xml > /dev/null <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="text/x-sln">
    <comment>Visual Studio Solution</comment>
    <glob pattern="*.sln"/>
  </mime-type>
</mime-info>
EOF

sudo update-mime-database /usr/share/mime

if [ ! -f /etc/xdg/mimeapps.list ]; then
    sudo tee /etc/xdg/mimeapps.list > /dev/null <<'EOF'
[Default Applications]
text/x-sln=jetbrains-rider.desktop

[Added Associations]
text/x-sln=jetbrains-rider.desktop;
EOF
else
    sudo grep -q "^\[Default Applications\]" /etc/xdg/mimeapps.list || \
      echo "[Default Applications]" | sudo tee -a /etc/xdg/mimeapps.list
    if ! sudo grep -q "^text/x-sln=jetbrains-rider.desktop" /etc/xdg/mimeapps.list; then
        sudo sed -i '/^\[Default Applications\]/a text/x-sln=jetbrains-rider.desktop' /etc/xdg/mimeapps.list
    fi
    sudo grep -q "^\[Added Associations\]" /etc/xdg/mimeapps.list || \
      echo "[Added Associations]" | sudo tee -a /etc/xdg/mimeapps.list
    if ! sudo grep -q "^text/x-sln=jetbrains-rider.desktop;" /etc/xdg/mimeapps.list; then
        sudo sed -i '/^\[Added Associations\]/a text/x-sln=jetbrains-rider.desktop;' /etc/xdg/mimeapps.list
    fi
fi

echo "JetBrains Rider Installed successfully, and set as the default application for .sln files."
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.jetbrains.com/rider/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
