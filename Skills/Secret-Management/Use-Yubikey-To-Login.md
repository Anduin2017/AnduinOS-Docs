# Use YubiKey To Login

If you want to enhance the security of your Linux desktop login, you can configure your system to use a YubiKey for authentication. This allows you to log in by simply touching your YubiKey, providing both convenience and strong security.

First, run the following script to install the necessary PAM module and configure GDM (GNOME Display Manager) to use your YubiKey for login authentication.

```bash title="One-click Setup for GDM Login with YubiKey"
# 1. Define the target file (Ubuntu/Debian usually uses gdm-password)
TARGET="/etc/pam.d/gdm-password"

# 2. Check if already configured
if grep -q "pam_u2f.so" "$TARGET"; then
    echo "⚠️  GDM is already configured for YubiKey."
else
    # 3. Backup original config
    sudo cp "$TARGET" "$TARGET.bak"
    
    # 4. Insert the auth rule at line 2 (Top priority)
    # This means: If key is touched, login immediately (skip password).
    sudo sed -i '2i auth       sufficient   pam_u2f.so cue' "$TARGET"
    echo "✅ Success! Next time you login or unlock screen, just touch the Key."
fi
```

Then lock your screen or log out to test the new configuration. When prompted for your password, simply touch your YubiKey to authenticate.

If anything goes wrong, please press `Ctrl + Alt + F3` to switch to a terminal, log in with your username and password, and restore the original PAM configuration:

```bashbash title="Restore GDM PAM Configuration"
sudo mv /etc/pam.d/gdm-password.bak /etc/pam.d/gdm-password
```

This will revert the changes and allow you to log in with your password again.