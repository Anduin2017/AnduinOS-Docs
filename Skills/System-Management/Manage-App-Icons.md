# Manage App Icons

When you click the start menu, you see a list of apps. These apps are represented by icons. Sometimes you may want to add a new app to the list, or view which command is executed when you click an app icon.

This tutorial will show you how to manage app icons\shortcuts in AnduinOS.

## System wide apps

To view all registered GUI system-wide apps, you can run the following command:

```bash title="View all registered GUI system-wide apps"
cd /usr/share/applications
ls
```

To view the content of a specific app, you can run the following command:

```bash
cd /usr/share/applications
cat <app-name>.desktop
```

For example, to view the content of the `org.gnome.Chess.desktop` app, you can run the following command:

```bash title="View the content of the org.gnome.Chess.desktop app"
anduin@anduin-System-Product-Name:/usr/share/applications$ cat ./org.gnome.Chess.desktop 
[Desktop Entry]
Name=Chess
GenericName=Chess Game
Comment=Play the classic two-player board game of chess
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=game;strategy;
Version=1.0
Exec=gnome-chess %U
Terminal=false
Type=Application
Categories=GNOME;GTK;Game;BoardGame;
StartupNotify=true
# Translators: Do NOT translate or transliterate this text (this is an icon file name)!
Icon=org.gnome.Chess
MimeType=application/x-chess-pgn;
DBusActivatable=true
# Translators: Do NOT translate or transliterate this text (these are enum types)!
X-Purism-FormFactor=Workstation;Mobile;
X-Ubuntu-Gettext-Domain=gnome-chess
```

Where the `Exec` field specifies the command to run the app, and the `Icon` field specifies the icon file name.

You can also create your new app. For example if you want to create a new app called `Virt Viewer`, you can run the following command:

```bash title="Create a new app"
sudo apt install virt-viewer
sudo su
echo "
[Desktop Entry]
Name=Virt Viewer
Comment=Connect to virtual machines
Exec=virt-viewer
Icon=virt-viewer
Terminal=false
Type=Application
Categories=System;" | sudo tee /usr/share/applications/virt-viewer.desktop
```

After creating the `.desktop` file, you can find the app in the apps list. And you can pin it to the start menu\taskbar or the desktop.

## User-specific apps

To view all registered GUI user-specific apps, you can run the following command:

```bash title="View all registered GUI user-specific apps"
cd ~/.local/share/applications
ls
```

Everything else is the same as system-wide apps.

## Manage desktop icons

To pin an app on the desktop, you need to copy the app's `.desktop` file to the desktop directory and allow execution.

You can also run the following command:

```bash title="Pin an app on the desktop"
cd ~/Desktop
cp /usr/share/applications/<app-name>.desktop
sudo chown $USER:$USER <app-name>.desktop
chmod +x <app-name>.desktop
```

For example, to pin the `org.gnome.Chess.desktop` app on the desktop, you can run the following command:

```bash title="Pin the org.gnome.Chess.desktop app on the desktop"
cd ~/Desktop
cp /usr/share/applications/org.gnome.Chess.desktop
sudo chown $USER:$USER org.gnome.Chess.desktop
chmod +x org.gnome.Chess.desktop
```

That's it! You have successfully added the app to the desktop.
