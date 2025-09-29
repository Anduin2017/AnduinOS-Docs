# MuseScore

!!! tip "AnduinOS Verified App - Open Source"

    MuseScore is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

MuseScore is a free and open-source music notation software. It is used to create, edit, and print sheet music.

## Flatpak install (Recommended)

You can install Code::Blocks via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub org.musescore.MuseScore
```

## System install

To install MuseScore on AnduinOS, run the following command:

```bash
sudo apt-get install musescore
```

Or you can install the AppImage version of MuseScore:

<!-- The link needs to be updated regularly. -->

```bash
wget https://cdn.jsdelivr.net/musescore/v4.5.2/MuseScore-Studio-4.5.2.251141401-x86_64.AppImage -O musescore.AppImage
chmod +x musescore.AppImage
./musescore.AppImage --appimage-extract
sudo mv squashfs-root /opt/musescore
sudo ln -s /opt/musescore/AppRun /usr/bin/musescore
echo "[Desktop Entry]
Name=MuseScore
Comment=Music Notation Software
Exec=/opt/musescore/AppRun
Icon=/opt/musescore/usr/share/icons/hicolor/512x512/apps/mscore4portable.png
Terminal=false
Type=Application
Categories=Audio;Music;" | sudo tee /usr/share/applications/musescore.desktop
```
