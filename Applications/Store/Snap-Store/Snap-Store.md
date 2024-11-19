# Install Snap Store as a Software Store

By default, AnduinOS doesn't come with Snap pre-installed.

!!! note "Why Snap is not pre-installed?"

    While Snap solved the package conflict problem, it introduced a new set of problems. Reference [this](https://www.reddit.com/r/linux/comments/j3ajnf/whats_wrong_with_snaps_why_so_many_people_hate_it/). Considering the user experience, we decided to remove Snap from AnduinOS.

If you you want to install Snap, you can run the following command:

```bash title="Install Snap"
sudo rm /etc/apt/preferences.d/no-snap.pref
sudo apt update
sudo apt install -y snapd
```

After installing Snap, you can install the Snap Store as a Software Store on AnduinOS.

## 1. Install Snap Store

To install Snap Store, simply run:

```bash
sudo snap install snap-store
sudo snap install snapd-desktop-integration
```

That's it! You can now open Snap Store from the Applications menu and start installing apps.

## 2. Restart

To complete setup, restart your system. Now all you have to do is [install some apps](https://snapcraft.io/store)!

## To remove Snap

If you want to remove Snap, you can run the following command:

```bash title="Remove Snap"
sudo snap remove snap-store || true
sudo snap remove snapd-desktop-integration || true
sudo snap remove bare || true
sudo apt purge -y snapd
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap
echo "Package: snapd
Pin: release a=*
Pin-Priority: -10" | sudo tee /etc/apt/preferences.d/no-snap.pref
sudo chown root:root /etc/apt/preferences.d/no-snap.pref
```
