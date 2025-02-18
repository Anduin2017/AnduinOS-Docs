# JetBrains Rider

JetBrains Rider is a cross-platform .NET IDE based on the IntelliJ platform and ReSharper.

To install JetBrains Rider on AnduinOS, you can run the following commands:

<!-- The link needs to be updated regularly. -->

```bash
# Download and extract the tarball.
url="https://download.jetbrains.com/rider/JetBrains.Rider-2024.3.5.tar.gz"
wget -O /tmp/rider.tar.gz "$url"
sudo tar -xzf /tmp/rider.tar.gz -C /opt
sudo rm -rf /opt/rider-old-backup
sudo mv /opt/rider /opt/rider-old-backup || true
sudo mv /opt/JetBrains\ Rider-2024.3.5 /opt/rider
sudo chown -R "$USER":"$USER" /opt/rider
rm /tmp/rider.tar.gz

# Create a launcher.
cat << EOF | sudo tee /usr/share/applications/jetbrains-rider.desktop >/dev/null
[Desktop Entry]
Name=JetBrains Rider
Comment=Integrated Development Environment
Exec=/opt/rider/bin/rider.sh
Icon=jetbrains-rider
Terminal=false
Type=Application
Categories=Development;IDE;
MimeType=application/x-ms-sln;
EOF

# Create a MIME type for .sln files.
cat << EOF | sudo tee /usr/share/mime/packages/sln.xml >/dev/null
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/x-ms-sln">
    <comment>Visual Studio Solution File</comment>
    <glob pattern="*.sln"/>
    <icon name="jetbrains-rider"/>
    <sub-class-of type="text/plain"/>
  </mime-type>
</mime-info>
EOF

# Install the icon.
sudo cp /opt/rider/bin/rider.svg /usr/share/icons/hicolor/scalable/apps/jetbrains-rider.svg
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

# Update MIME database and desktop database.
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

# Set system default association.
sudo mkdir -p /etc/gnome/defaults.list.d
echo 'application/x-ms-sln=jetbrains-rider.desktop' | sudo tee /etc/gnome/defaults.list.d/rider-sln.conf >/dev/null

# Apply the default association. (Only works for current user)
xdg-mime default jetbrains-rider.desktop application/x-ms-sln
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://www.jetbrains.com/rider/) to get the latest version.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
