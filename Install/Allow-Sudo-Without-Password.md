# Allow sudo without password

Allowing sudo without password is a security risk, but it can be useful in certain situations.

!!! warning "Security Risk"

    Disabling the password requirement for sudo can be a security risk. This may cause some commands running without sudo to have root permissions and potentially break your system.

However, if you prefer to allow sudo without password, you can follow the steps below.

Open the sudoers file with the visudo command:

```bash title="Allow sudo without password"
sudo mkdir -p /etc/sudoers.d
sudo touch /etc/sudoers.d/$USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USER
```

That's it! You can now run sudo commands without entering your password.

## Suggested: Use YubiKey to authenticate sudo

Instead of completely disabling passwords (which is risky), you can configure Linux to accept a physical touch on your YubiKey as authentication. This offers **password-less convenience** with **hardware-level security**.

Run this script to install dependencies, register your key, and update the sudo configuration automatically.

```bash title="One-click Setup for Sudo with YubiKey"
# 1. Install necessary PAM module
sudo apt update
sudo apt install -y libpam-u2f

# 2. Register YubiKey (if not already registered)
mkdir -p ~/.config/Yubico
if [ ! -s ~/.config/Yubico/u2f_keys ]; then
    echo "👉 Please touch your YubiKey now to register it..."
    pamu2fcfg > ~/.config/Yubico/u2f_keys
fi

# 3. Configure PAM to allow YubiKey authentication
if grep -q "pam_u2f.so" /etc/pam.d/sudo; then
    echo "⚠️  Sudo is already configured for YubiKey."
else
    # Backup original config
    sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak
    
    # Insert the auth rule at line 2 (right after include common-auth)
    sudo sed -i '2i auth       sufficient   pam_u2f.so cue' /etc/pam.d/sudo
    echo "✅ Success! Try running 'sudo -k' then 'sudo ls' to test."
fi

```

To learn more about how to use Yubikey to protect your SSH key, you can continue read more here: [Manage SSH Keys with Yubikey](https://www.google.com/search?q=../Skills/Secret-Management/Manage-SSH-Keys-with-Yubikey.md) guide to set up your YubiKey for SSH authentication.
