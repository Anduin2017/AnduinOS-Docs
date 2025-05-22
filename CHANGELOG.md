# AnduinOS Changelog

## v1.3.2 (Under development)

* Added `cracklib-runtime` package to the default app list.
* Added `libfuse2t64`, `libfuse3-3` and `libopengl0` to the default app list to support AppImage.
* Use dynamic trackers retrieval from online source to generate torrent files.
* Added `power-profiles-daemon` to the default app list.
* For `zh_CN` version, changed default flathub mirror from `sjtu` to `ustc`.
* Added `vim` to the default app list.
* Added `software-properties-gtk`(Modified), `libgtk3-perl`, `python3-dateutil` and `gir1.2-handy-1` to the default app list. Hold `software-properties-gtk` to prevent it from being upgraded.
* Added Intel `thesofproject/sof-bin` firmware to support Intel audio devices (Tested on Lunarlake CPU).
* Created pin file under `/etc/apt/preferences.d/` to prevent `software-properties-gtk` and `base-files` from being upgraded.
* Fixed an issue that theme and icon may be reverted to default after reboot.

## v1.3.1

* Fixed an issue that `nautilus` may crash when clicking `Network`.
* Changed the text of the image during boot(grub menu) from `Install AnduinOS` to `Try and Install AnduinOS`.
* Added `en_GB` locale to the default locale list to support British English.
* Fixed an issue that `nautilus admin:/` command result in `admin locations are not supported` error.
* Fixed an issue that the installer `ubiquity` doesn't follow system theme.
* Added `gvfs-background` to the default app list to support `admin://` protocol.
* Added `libpam-gnome-keyring` package to avoid gnome-keyring asking for password when login.
* Fixed `fr_FR` font issue that caused some characters to be displayed incorrectly. Adjusted default fallback order for sans-serif, serif, and monospace to prioritize Latin fonts while retaining proper CJK support.

## v1.3.0 (Forked from v1.2.0)

* **Upgraded Base System**: The foundational system has been updated from **Oracular (Ubuntu 24.10)** to **Plucky (Ubuntu 25.04)**.
* Added a new shortcut **Super + V** to toggle the clipboard history.
* Preinstalled `gnome-software` to support installing software from the software store.
* Preinstalled `flatpak` to support installing software from the software store.
* Fixed Firefox localization issue.
* Bumped Gnome to 48 and added HDR support.

## v1.2.5 (Under development)

* Fix qalculate localization issue that may not show localized text.
* Added `en_GB` locale to the default locale list to support British English.
* Fixed an issue that the installer `ubiquity` doesn't follow system theme.
* Fixed `fr_FR` font issue that caused some characters to be displayed incorrectly. Adjusted default fallback order for sans-serif, serif, and monospace to prioritize Latin fonts while retaining proper CJK support.
* Added `cracklib-runtime` package to the default app list.
* Changed the text of the image during boot(grub menu) from `Install AnduinOS` to `Try and Install AnduinOS`.
* Added `libfuse2t64`, `libfuse3-3` and `libopengl0` to the default app list to support AppImage.
* Use dynamic trackers retrieval from online source to generate torrent files.
* Added `power-profiles-daemon` to the default app list.
* Added `vim` to the default app list.
* Added `software-properties-gtk`(Modified), `libgtk3-perl`, `python3-dateutil` and `gir1.2-handy-1` to the default app list. Hold `software-properties-gtk` to prevent it from being upgraded.
* Created pin file under `/etc/apt/preferences.d/` to prevent `software-properties-gtk` and `base-files` from being upgraded.
* Fixed an issue that theme and icon may be reverted to default after reboot.

## v1.2.4

* Added torrent files for downloading the ISO.
* Added `clipboard-indicator@tudmotu.com` plugin to the default plugin list.
* Fixed an issue that the homepage of Firefox may not be able to be adjusted.
* Added package `gstreamer1.0-libav` to the default app list.
* Added the following packages to the default app list:
  * orca
  * spice-vdagent
  * bpfcc-tools
  * bpftrace
  * exfatprogs
  * gdb
  * gir1.2-wnck-3.0
  * ieee-data
  * iw
  * linux-headers
  * linux-tools

## v1.2.3

* Bump packages to the latest version.

## v1.2.2

* Suppress a notification from ArcMenu by default.

## v1.2.1

* Fixed a keyboard shortcut conflict that caused the **Super + N** shortcut to toggle notifications center.
* Fixed a keyboard shortcut conflict that caused the **Super + A** shortcut to toggle action center.

## v1.2.0 (Forked from v1.1.0)

* **Upgraded Base System**: The foundational system has been updated from **Noble (Ubuntu 24.04)** to **Oracular (Ubuntu 24.10)**.

## v1.1.5 (Under development)

* Added package `gstreamer1.0-libav` to the default app list.
* Fix qalculate localization issue that may not show localized text.
* Added `en_GB` locale to the default locale list to support British English.
* Fixed an issue that the installer `ubiquity` doesn't follow system theme.
* Fixed `fr_FR` font issue that caused some characters to be displayed incorrectly. Adjusted default fallback order for sans-serif, serif, and monospace to prioritize Latin fonts while retaining proper CJK support.
* Added `cracklib-runtime` package to the default app list.
* Changed the text of the image during boot(grub menu) from `Install AnduinOS` to `Try and Install AnduinOS`.
* Added `libfuse2t64`, `libfuse3-3` and `libopengl0` to the default app list to support AppImage.
* Use dynamic trackers retrieval from online source to generate torrent files.
* Added `power-profiles-daemon` to the default app list.
* Added `vim` to the default app list.
* Added `software-properties-gtk`(Modified), `libgtk3-perl`, `python3-dateutil` and `gir1.2-handy-1` to the default app list. Hold `software-properties-gtk` to prevent it from being upgraded.
* Created pin file under `/etc/apt/preferences.d/` to prevent `software-properties-gtk` and `base-files` from being upgraded.
* Fixed an issue that theme and icon may be reverted to default after reboot.

## v1.1.4

* Added torrent files for downloading the ISO.
* Added `clipboard-indicator@tudmotu.com` plugin to the default plugin list.
* Fixed an issue that the homepage of Firefox may not be able to be adjusted.
* Added the following packages to the default app list:
  * orca
  * spice-vdagent
  * bpfcc-tools
  * bpftrace
  * exfatprogs
  * gdb
  * gir1.2-wnck-3.0
  * ieee-data
  * iw
  * linux-headers
  * linux-tools

## v1.1.3

* Bump packages to the latest version.

## v1.1.2

* Suppress a notification from ArcMenu by default.

## v1.1.1

* Fixed a keyboard shortcut conflict that caused the **Super + N** shortcut to toggle notifications center.
* Fixed a keyboard shortcut conflict that caused the **Super + A** shortcut to toggle action center.

## v1.1.0 (Forked from v1.0.6)

* Refactored the branch management. Branches will now follow the "Fork version" naming convention (e.g., 1.0, 1.1, 1.2). "Dot versions" will now be represented as tags instead of branches.
* The foundational system has been updated from **Jammy (Ubuntu 22.04)** to **Noble (Ubuntu 24.04)**.
* Replaced `gedit` with `gnome-text-editor` as the default text editor.
* Removed **Rounded Window Corners Extension** due to instability and performance issues in GNOME 45+ environments.
* Removed **Audio Output Switcher Extension** due to compatibility issues with GNOME 45+.
* Updated the `README.md` file to include detailed instructions for users to compile their own AnduinOS builds.
* The ISO boot menu now includes additional options such as **Safe Graphics**, **Next Volume**, and **UEFI Firmware Settings**.
* Replaced `xz` compression with `zstd` for faster and more efficient ISO generation.
* The ISO now consolidates the previous **Try Mode** and **Install Mode** into a unified **Install Mode**.
* Daily builds will now only support English and Chinese language options. Available to download from the [AnduinOS website](https://anduinos-nightly-builds.aiursoft.cn/).
* Added: `apt-utils`, `crash`, `debconf-i18n`, `fdisk`, `grub-efi-amd64`, `hwdata`, `info`, `init`, `numactl`, `cloud-init`, `coreutils`, `dnsutils`, `gvfs-fuse`, `htop`, `httping`, `libsass1`, `squashfs-tools`, `sysstat`, `thermald`, `traceroute`, `vim`, `whiptail`, `openvpn`, `network-manager-openvpn`, `network-manager-openvpn-gnome`, `network-manager-pptp-gnome`, `ibus`, `gnome-snapshot`, `gnome-text-editor`, `gstreamer1.0-libav`, `gstreamer1.0-alsa`, `gstreamer1.0-vaapi`, `gstreamer1.0-tools`, `gstreamer1.0-packagekit`, `gstreamer1.0-plugins-base-apps`, `alsa-base`, `fprintd`, `pipx`.  
* Removed: `wireless-tools`, `cheese`, `gedit`, `nautilus-extension-gnome-console`, `zutty`.
* Switched from using `pip3` to `pipx` for installing `gnome-extensions-cli`.  
* Replaced `openweather-extension@jenslody.de` with `openweather-extension@penguin-teal.github.io`.  
* Added new GNOME extensions: `mediacontrols@cliffniff.github.com`,`loc@anduinos.com`, `loc@anduinos.com`.
* Redesigned the dark/light theme switcher to listen for system theme changes and apply the theme accordingly.
* Users can now directly enable/disable location service from the action center.
* Set the default cursor size to **32**, based on feedback from [Arch Linux forums](https://bbs.archlinux.org/viewtopic.php?id=299624).
* The **Super + Up Arrow** shortcut now toggles fullscreen mode instead of enabling it.
* Updated the visual indicator for highlighted applications on the taskbar from **dashes effect** to **segmented effect**.
* The Ubuntu startup sound is now disabled by default.
* Set `kernel.apparmor_restrict_unprivileged_userns` to **0**, addressing concerns raised in [Ask Ubuntu](https://askubuntu.com/questions/1511854/how-to-permanently-disable-ubuntus-new-apparmor-user-namespace-creation-restric).
* Changed the default live environment username to **live**.
* The ISO now includes a pre-generated Netplan configuration file.
* The compiled ISO has already run `apt update`, ensuring better user experience in the live environment with proper command hints and install suggestions.

## v1.0.7

* Bump packages to the latest version.

## v1.0.6

* Added the following packages to the default app list:
  * `apt-utils`, `crash`, `debconf-i18n`, `fdisk`, `grub-efi-amd64`, `hwdata`, `info`, `init`, `numactl`, `cloud-init`, `coreutils`, `dnsutils`, `gvfs-fuse`, `htop`, `httping`, `libsass1`, `squashfs-tools`, `sysstat`, `thermald`, `traceroute`, `vim`, `whiptail`, `openvpn`, `network-manager-openvpn`, `network-manager-openvpn-gnome`, `network-manager-pptp-gnome`, `ibus`, `gnome-text-editor`, `gstreamer1.0-libav`, `gstreamer1.0-alsa`, `gstreamer1.0-vaapi`, `gstreamer1.0-tools`, `gstreamer1.0-packagekit`, `gstreamer1.0-plugins-base-apps`, `alsa-base`, `fprintd`, `pipx`.

## v1.0.5

* Added **GNOME Maps** to the default app suite for enhanced navigation experiences.
* Replaced **Audio Output Switcher** with **Sound Output Device Chooser** for a more streamlined and intuitive audio device selection experience.
* Introduced the **Lock Keys** GNOME extension, which provides a visual indicator on the taskbar when **Caps Lock** is enabled.
* Added the **Tiling Assistant** GNOME extension, offering advanced window tiling and management capabilities for improved multitasking.
* The **Location Service** is now disabled by default to prioritize user privacy.

## v1.0.4

* Fixed an issue that the `help` feature in some gnome apps might not work.
* Generate the `/etc/locale.gen` file to enable all locales by default.

## v1.0.3

* Added `gnome-bluetooth`, `gnome-power-manager`, `gnome-maps` to the default app list.

## v1.0.2

* Use Qalculate gtk to replace Gnome Calculator.

## v1.0.1

* Fixed an issue that Secure Boot may not work.
* Added new locales: `pt_BR`.
* Fixed the package `base-files` to avoid Ubuntu to upgrade to the next version.
* Fixed the localization to replace `Add to favorites` with `Pin to taskbar`.
* Added a new gnome plugin `rounded-window-corners@yilozt` to make the window corners rounded and looks more like Windows 11.

## v1.0.0

* Added a new keyboard shortcut `Windows + U` to toggle the display network state on the taskbar.
* Removed the `htop.desktop` file since nobody uses it.
* Default sleep time after inactivity is set to 30 minutes on AC power and 20 minutes on battery.
* Chinese mainland users no-longer installs `ibus-libpinyin` by default. Instead, only `ibus-rime` will be installed.
* Taiwan users no-longer installs `ibus-cangjie` and `ibus-libzhuyin`. Instead, only `ibus-chewing` will be installed.
* Japan users no-longer installs `ibus-anthy`. Instead, only `ibus-mozc` will be installed.
* de_DE, fr_FR, ru_RU, it_IT, pt_PT, ar_SA, nl_NL, sv,SE non-longer install an input method by default. Instead, their keyboard layout will be set to the corresponding language. So:
  *  `zh-hans` will install `ibus-rime` by default.
  *  `zh-hant` will install `ibus-chewing` by default. (Taiwan)
  *  `zh-hant` will install `ibus-table-cangjie` by default. (Hong Kong)
  *  `ja` will install `ibus-mozc` by default.
  *  `ko` will install `ibus-hangul` by default.
  *  `vi` will install `ibus-unikey` by default.
  *  `th` will install `ibus-libthai` by default.
* United state users' timezone set to Los Angeles by default. (Pacific Time) Instead of New York.

## v0.3.1-rc

* The default city for weather will be set to corresponding to the locale of the build.
* Add default world clock with `Seattle`, `Beijing`, `New York` and `GMT`.
* Ubiquity slides-show was localized for all supported languages.
* Built ISO root folder will have a `README.md` file to show the version number.
* Removed packages: `aisleriot`, `iotop`, `iftop`, `tree`, `w3m`, `sysbench`, `nethogs`, `iperf3`, `dmz-cursor-theme`. (Users can install them manually via `sudo apt install`)
* Added packages: `gnome-characters`, `gnome-font-viewer`, `gnome-chess`.
* Login page will use `Fluent` cursor theme by default.
* Default apt mirror for United States switch to `http://archive.ubuntu.com/ubuntu/` considering this version may be used by global users.

## v0.3.0-rc

* Based on language, will auto install the corresponding input method.
* Based on language, will auto select the corresponding apt mirror.
* Based on language, will auto select the corresponding timezone.
* The `LANG` environment variable will be patched to `/etc/default/locale`.

## v0.2.2-beta

* The homepage of firefox will be set to `https://anduinos.com/` by default.
* Slightly changed the text of ubiquity slideshow for better localization.
* Support multiple languages iso file. (Chinese, English)

## v0.2.1-beta

* Added `fprintd` and `libpam-fprintd` to support fingerprint login.
* Removed `gnome-tweaks` from the default app list to reduce to avoid distraction.
* Use `gedit` to replace `gnome-text-editor` as the default text editor, because `gnome-text-editor` may having some issue with ibus.
* Rime will no longer be preinstalled due to its high disk and memory usage, especially for users without Chinese input needs. Instead, only ibus will be preinstalled. Users can install Rime manually via `sudo apt install ibus-rime`, or use the custom [AnduinOS-Rime](https://gitlab.aiursoft.cn/anduin/anduinos-rime) input method if needed.
* Patch `baobab` localization for Chinese.
* Refactor AnduinOS build script as modularized functions.

## v0.2.0-beta

* Updated kernel version from `6.5.0-45-generic` to `6.8.0-40-generic`.
* Updated font settings:
  * Default interface font: `Sans 11`
  * Default document font: `Ubuntu Mono 13`
  * Default monospace font: `Monospace 11`
  * Default gnome-text-editor font: `Ubuntu Mono 13`
* Nolonger install `info` to reduce the size of the ISO file.
* Added `alsa-utils`, `firmware-sof-signed` to support audio control.
* Hide network stat icon on taskbar.
* Hide power button on taskbar.
* Hide network state on taskbar by default. (User can enable it back in the gnome extension settings)
* Adjust the default power settings:
  * Auto dim after inactivity: 15 minutes
  * Auto sleep after inactivity: 30 minutes
  * Lock screen right after screen is blanked.
  * Power button action: Suspend(sleep)
  * Lid close action: Suspend(sleep)

## v0.1.4-beta

* Scrolling on taskbar nolonger switch workspace.
* Added a new shortcut `<Super> + G` to start screen recording.
* Added a new shortcut `<Super> + F11` to toggle full screen.
* Added a new shortcut `<Super> + BackSpace` to toggle the zoom feature.
* Added a new shortcut `<Super> + M` to minimize the current window.
* Added `cups` and `system-config-printer` packages to support printing.
* The theme switcher gnome plugin will nolonger switch user's wallpaper. Set AnduinOS wallpaper as default.
* Patch arcmenu for localization "关机" "重启" "新增" "从开始菜单取消固定" "固定到任务栏"

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
* Added a `Software-store` pointing to `https://docs.aiursoft.cn/Applications/Introduction.html` in the start menu.
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
