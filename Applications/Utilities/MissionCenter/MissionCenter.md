# Mission Center

Mission Center is a tool that allows you to monitor your CPU, Memory, Disk, Network and GPU usage.

To install Mission Center on AnduinOS, you can run:

```bash
APPIMAGE_URL="https://gitlab.com/mission-center-devs/mission-center/-/jobs/7109267599/artifacts/raw/MissionCenter-x86_64.AppImage"
LOGO_URL="https://dl.flathub.org/media/io/missioncenter/MissionCenter/224cb83cac6b6e56f793a0163bcca7aa/icons/128x128/io.missioncenter.MissionCenter.png"
APPIMAGE_PATH="/opt/missioncenter.appimage"
APPBIN_PATH="/opt/missioncenter/AppRun"
LOGO_PATH="/usr/share/icons/missioncenter.png"
DESKTOP_FILE="/usr/share/applications/missioncenter.desktop"
sudo wget -O $APPIMAGE_PATH $APPIMAGE_URL
sudo wget -O $LOGO_PATH $LOGO_URL
sudo chmod +x $APPIMAGE_PATH
sudo $APPIMAGE_PATH --appimage-extract
sudo mv ./squashfs-root /opt/missioncenter
sudo rm $APPIMAGE_PATH
echo "[Desktop Entry]
Name=MissionCenter
Comment=Monitor overall system and application performance
Exec=$APPBIN_PATH
Icon=$LOGO_PATH
Terminal=false
Type=Application
Categories=System;Monitor;" | sudo tee $DESKTOP_FILE
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
