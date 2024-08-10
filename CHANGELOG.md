# AnduinOS Changelog

## v0.1.3-beta

* Install Fluent cursor theme
* Edited `Home_url` in `/etc/os-release` to point to the AnduinOS website.
* Added a wallpaper for light theme.
* Use overlay instead of ramdisk for loading the live environment.
* Use AnduinOS's own gnome plugin to switch light and dark themes.
* Hide the Ubuntu logo in `gnome-control-center`.
* Hide the dark\light theme switch in `gnome-control-center`.
* Live environment (including installer) will use the new mirror `http://mirrors.anduinos.com` by default.
* Gnome console will use the AnduinOS theme by default. (instead of the dark theme)
* Arcmenu will use the AnduinOS theme by default. (instead of the dark theme)

## v0.1.2-beta

* Added `ubuntu-drivers-common` to the default app list to simplify the driver installation process.
* Removed `apport` and `python3-systemd` to reduce the size of the ISO file.
* Removed `neofetch` from default app list to reduce the size of the ISO file.
* Removed `/etc/update-manager/` and `/etc/update-motd.d/` to simplify the message after login.

## v0.1.1-beta

* Simplified the name of this OS to `v0.1.1-beta`. Removed the `jammy` word.
* Compress the ubiquity slideshow images to reduce the size of the ISO file.
* Added a new command `do_anduinos_upgrade` to upgrade the system to the latest version.
* Fix a typo in `/etc/lsb_release`.
* Patched `/etc/issue` to show the AnduinOS brand.
* Patched `/etc/issue.net` to show the AnduinOS brand.
* Created `.disk/info` file under the root of the ISO file to show the AnduinOS brand.
* Fixed an issue that in `Ubiquity-slideshow` the `Privacy` page may miss an image.
* Software store link changed to `https://docs.anduinos.com/`.
* Use AnduinOS own website instead of GitHub to distribute release.

## v0.1.0-beta-jammy

* Removed `gnome-software`, `software-properties-gtk`, `ubuntu-pro-client`, `ubuntu-advantage-desktop-daemon`, `ubuntu-advantage-tools`, `ubuntu-pro-client-l10n`, `gnome-software-common`, `gnome-software-plugin-snap` to reduce the size of the ISO file.
* Added a `Software-store` pointing to `https://anduinos-docs.aiursoft.cn/Applications/Introduction.html` in the start menu.
* Patch `Ubiquity-slideshow` to show the AnduinOS introduction.
* Patch the `/etc/casper.conf` to change the default live session username to `try-user` and hostname to `anduinos`.

## v0.0.9-alpha-jammy

* Fixed an issue that `/etc/lsb_release` and `/etc/os-release` may not have the correct version number.
* Add `audio-output-switcher@anduchs` to the default gnome-shell extension list.
* Patch Chinese localization for `Rhythmbox`.

## v0.0.8-alpha-jammy

* Remove package `update-manager-core` to avoid the user upgraded to Ubuntu next version. (AnduinOS will handle the upgrade)
* Use totem as the default video player instead of vlc.
* Add `https://github.com/tomflannaghan/proxy-switcher` to the default gnome-shell extension list.
* Add `transmission-gtk` to the default app list.
* Add `rhythmbox` to the default app list and start menu.
* Edited default app mime types to open with the default app.
  * totem for video files.
  * rhythmbox for audio files.
  * transmission-gtk for torrent files.
  * file-roll for archive files.
  * gnome-text-editor for text files.
  * gdebi for deb files.
  * shotwell for photo files.
* Remove imagemagick from the default app list to reduce the size of the ISO file.

## v0.0.7-alpha-jammy

* Refactor the resources files structure during the build process.
* Patch fonts with `CascadiaCode, NerdFontsSymbols, Noto_Sans, Noto_serif, TwitterColorEmoji-SVGinOT` to support more languages.

## v0.0.6-alpha-jammy

* Removed useless system gnome extensions to reduce the size of the ISO file.
* By default disable magnifier. This will disable keyboard shortcut `Super + =` and `Super + -`. But better performance.
* Patch `ArcMenu` to show `Pin to Start menu` instead of `Pin to ArcMenu`.
* Edited taskbar behavior to activate panel menu buttons on click instead of hover.
* Hide date on the taskbar.
* Ubiquity installer will show the AnduinOS wallpaper.
* Added `fonts-noto-cjk fonts-noto-core fonts-noto-mono fonts-noto-color-emoji` to support more languages.
* Compress the squashfs file with `xz` to reduce the size of the ISO file.

## v0.0.5-alpha-jammy

* First open terminal nolonger shows the `sudo` hint.
* By default install with `ubuntu-session`, `yaru-theme-sound` and `yaru-theme-gnome-shell`
* Nolonger install `MissionCenter` since it's an app image and may increase the size of the ISO file.
* Install `gnome-system-monitor` and `gnome-sound-recorder` by default.
* `Ctrl + Shift + ECS` will open `gnome-system-monitor` instead of `MissionCenter`.
* Fixed an issue that `Super + Left` and `Super + Right` may not work.
* Patch Chinese localization for `shotwell.desktop`.
* Reset arcmenu (start menu) icons to default for better localization.
* Start menu added some buttons for files, settings, console. Next to Power button.
* Added keyboard shortcut `Super + =` and `Super + -` to zoom in and out.

## v0.0.4-alpha-jammy

* Fixed an issue that after system boot, gnome may show overview.
* Fixed an issue that `Super + D` may not work.
* Changed keyboard shortcut to make `Super + N` to open notification center.
* Nolonger patch `/etc/fonts/local.conf`. Leave font configuration as default.
* Removed `qtwayland5` package to reduce the size of the image.
* ISO file nolonger has the `Install` folder.
* OS pretty name nolonger has the word `based on Ubuntu Jammy`.
* Grub menu nolonger has the `Check Disk for defects` option.

## v0.0.3-alpha-jammy

* Removed the `Check Disk` option in the boot menu.
* Update README file to include the method about how to burn a bootable USB drive.
* Update the splash screen (Plymouth) to show the logo of AnduinOS.
* Super + Shift + S will take a screenshot.
* Simplify the start menu default apps text.
* Remove the gnome-system-monitor from the default apps because it's duplicate with Mission Center.
* Clean up `/opt/themes` folder to remove unnecessary themes files.

## v0.0.2-alpha-jammy

* Fix an issue that cursor may missing a necessary theme.
* Set version number in /etc/lsb-release and /etc/os-release.
* Added Chinese language pack (12MB larger)

## v0.0.1-alpha-jammy

First release. Able to boot into the desktop environment.