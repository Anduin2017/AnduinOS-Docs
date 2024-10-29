# Change AnduinOS's distro name to other Linux distro names

In some cases, for exmaple, some software may only support specific Linux distributions, you may need to change AnduinOS's distro name to other Linux distro names. In this guide, we will show you how to change AnduinOS's distro name to other Linux distro names.

For example, if you want to change AnduinOS to Ubuntu without reinstalling the system, you can follow these steps:

```bash
sudo apt reinstall lsb-release distro-info-data base-files
```

That's it! You have successfully changed AnduinOS's distro name to Ubuntu. You can now use software that only supports Ubuntu on your system.

To verify the change, you can run the following command:

```bash
lsb_release -a
```

You may observe `Ubuntu` as the distro name in the output.

## Next step

After changing your distro name, you can install some Ubuntu-specific software on your system. For example, you can install `software-properties-gtk` to manage software sources:

```bash
sudo apt install software-properties-gtk gir1.2-goa-1.0 python3-dateutil ubuntu-advantage-desktop-daemon \
  ubuntu-advantage-tools ubuntu-pro-client ubuntu-pro-client-l10n ubuntu-drivers-common ubuntu-release-upgrader-core \
  ubuntu-release-upgrader-gtk ubuntu-report ubuntu-settings uno-libs-private update-manager update-manager-core update-notifier \
  update-notifier-common gnome-software gnome-software-common gnome-power-manager
```

And of course you can upgrade your Ubuntu system to the latest version:

```bash
sudo do-release-upgrade
```
