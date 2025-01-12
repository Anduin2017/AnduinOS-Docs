# Nextcloud Talk

Nextcloud Talk is a self-hosted, secure, and private audio/video and chat communication platform. It is a part of the Nextcloud ecosystem and can be used to communicate with other Nextcloud users.

To install Nextcloud Talk on Linux, you can run the following script:

```bash
#!/bin/bash

# Define variables
TALK_URL="https://github.com/nextcloud-releases/talk-desktop/releases/latest/download/Nextcloud.Talk-linux-x64.zip"
ICON_URL="https://raw.githubusercontent.com/nextcloud/talk-desktop/refs/heads/main/img/talk-icon-rounded-spaced.svg"

TALK_ZIP_PATH="/opt/nextcloudtalk.zip"
TALK_INSTALL_DIR="/opt/NextcloudTalk"
TALK_BIN="$TALK_INSTALL_DIR/Nextcloud Talk"

ICON_PATH="/usr/share/icons/nextcloudtalk.svg"
DESKTOP_FILE="/usr/share/applications/nextcloudtalk.desktop"

# Download Nextcloud Talk
sudo -E wget -O "$TALK_ZIP_PATH" "$TALK_URL"
if [ ! -f "$TALK_ZIP_PATH" ]; then
  echo "Error: Failed to download Nextcloud Talk ZIP file."
  exit 1
fi

# Download the icon
sudo -E wget -O "$ICON_PATH" "$ICON_URL"

# Unzip and install Nextcloud Talk
sudo -E unzip "$TALK_ZIP_PATH" -d /opt || { echo "Error: Failed to unzip Nextcloud Talk."; exit 1; }
sudo -E rm "$TALK_ZIP_PATH"
sudo -E mv "/opt/Nextcloud Talk-linux-x64" "$TALK_INSTALL_DIR"
sudo -E chmod 755 "$TALK_INSTALL_DIR" -R
sudo -E chmod +x "$TALK_BIN"

# Create symbolic link, overwrite if it exists
sudo -E ln -sf "$TALK_BIN" /usr/bin/nextcloudtalk

# Create desktop entry
echo "[Desktop Entry]
Name=Nextcloud Talk
Comment=Nextcloud Talk Desktop Client
Exec=$TALK_BIN
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Network;Chat;Communication;" | sudo -E tee "$DESKTOP_FILE"

echo "Installation completed successfully."

```
