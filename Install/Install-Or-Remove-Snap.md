# Install or remove Snap

By default, AnduinOS doesn't come with Snap pre-installed.

!!! note "Why Snap is not pre-installed?"

    While Snap solved the package conflict problem, it introduced a new set of problems. Reference [this](https://www.reddit.com/r/linux/comments/j3ajnf/whats_wrong_with_snaps_why_so_many_people_hate_it/). Considering the user experience, we decided to remove Snap from AnduinOS.

To tell if you have Snap installed, you can run the following command:

```bash
snap --version
```

If you you want to install Snap, you can run the following command:

```bash title="Install Snap"
sudo rm /etc/apt/preferences.d/no-snap.pref
sudo apt update
sudo apt install -y snapd
```

If you want to remove Snap, you can run the following command:

```bash title="Remove Snap"
sudo snap remove firefox || true
sudo snap remove snap-store || true
sudo snap remove gtk-common-themes || true
sudo snap remove snapd-desktop-integration || true
sudo snap remove bare || true
sudo apt purge -y snapd
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap
echo "Package: snapd
Pin: release a=*
Pin-Priority: -10" | sudo tee /etc/apt/preferences.d/no-snap.pref
sudo chown root:root /etc/apt/preferences.d/no-snap.pref
```
