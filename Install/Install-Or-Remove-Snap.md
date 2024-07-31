# Install or remove Snap

By default, AnduinOS doesn't come with Snap pre-installed.

This is because while Snap solved the package conflict problem, it introduced a new set of problems. [Snap](https://www.reddit.com/r/linux/comments/j3ajnf/whats_wrong_with_snaps_why_so_many_people_hate_it/) has some issues that may cause problems for users.

To tell if you have Snap installed, you can run the following command:

```bash
snap --version
```

If you you want to install Snap, you can run the following command:

```bash
sudo rm /etc/apt/preferences.d/no-snap.pref
sudo apt update
sudo apt install -y snapd
```

If you want to remove Snap, you can run the following command:

```bash
snap remove firefox || true
snap remove snap-store || true
snap remove gtk-common-themes || true
snap remove snapd-desktop-integration || true
snap remove bare || true
apt purge -y snapd
rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap
cat << EOF > /etc/apt/preferences.d/no-snap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
chown root:root /etc/apt/preferences.d/no-snap.pref
```
