# Signal

!!! tip "AnduinOS Verified App - Open Source"

    Signal is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Signal is a cross-platform encrypted messaging service. It is available for Android, iOS, Windows, macOS, and Linux. Signal uses end-to-end encryption to keep your conversations private and secure.

To install Signal on AnduinOS, you can use the following command:

```bash title="Install Signal"
# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop
```
