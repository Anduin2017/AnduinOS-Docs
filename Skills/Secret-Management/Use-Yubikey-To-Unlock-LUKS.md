# Use Yubikey To Unlock LUKS

If you have a LUKS-encrypted root partition on your Linux system, you can enhance its security and convenience by configuring it to unlock using a YubiKey in FIDO2 mode. This setup allows you to unlock your disk at boot by simply touching your YubiKey.

**⚠️ Risk Warning:** This configuration replaces Ubuntu's default `initramfs-tools` with `dracut`. While robust, changing core boot components carries risks. **Ensure you have backups.**

This setup allows you to unlock your LUKS-encrypted root partition at boot by simply touching your YubiKey (FIDO2 mode).

## 1. Enroll YubiKey

First, ensure your YubiKey is registered as a valid unlocking method for your encrypted partition.

Use the following script to safely install `dracut` (if missing), configure `/etc/crypttab` with the correct UUID, and generate the boot image.

```bash title="Setup Disk Unlock (Smart Script)"
# --- 1. Find Encrypted Partition ---
echo "🔍 Scanning for LUKS partition..."
# Find partition name
PART_NAME=$(lsblk -r -o NAME,FSTYPE | grep crypto_LUKS | head -n 1 | cut -d " " -f 1)

if [ -z "$PART_NAME" ]; then
    echo "❌ No LUKS partition found."
else
    PART_DEV="/dev/$PART_NAME"
    # Use blkid to get clean UUID
    PART_UUID=$(sudo blkid -s UUID -o value "$PART_DEV")
    
    echo "✅ Target: $PART_DEV"
    echo "🔑 UUID:   $PART_UUID"

    # --- 2. Smart Enroll (Skip if exists) ---
    echo "🔍 Checking existing keys..."
    if sudo systemd-cryptenroll "$PART_DEV" | grep -q "fido2"; then
        echo "✅ FIDO2 already enrolled. Skipping enrollment."
    else
        echo "👉 Enroll New Key: You will be asked for DISK PASSWORD, then TOUCH KEY."
        sudo systemd-cryptenroll --fido2-device=auto "$PART_DEV"
        # Touch the YubiKey when prompted
        echo "✅ Enrollment complete."
    fi

    # --- 3. Dracut Check & Install ---
    PROCEED_CONFIG=false
    if command -v dracut &> /dev/null; then
        echo "✅ Dracut detected. Skipping installation."
        PROCEED_CONFIG=true
    else
        echo ""
        echo "⚠️  CRITICAL: Dracut not found."
        read -p "   Install Dracut now? [y/N] " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo "📦 Installing Dracut..."
            sudo apt-get update -qq && sudo apt-get install -y dracut
            PROCEED_CONFIG=true
        else
            echo "❌ Cancelled."
        fi
    fi

    # --- 4. Configure & Build ---
    if [ "$PROCEED_CONFIG" = true ]; then
        echo "📝 Re-creating /etc/crypttab..."
        
        # Determine mapper name
        MAPPER_NAME=$(lsblk -rn -o NAME,TYPE | grep crypt | awk '{print $1}' | head -n 1)
        [ -z "$MAPPER_NAME" ] && MAPPER_NAME="${PART_NAME}_crypt"
        
        # Backup existing file
        [ -f /etc/crypttab ] && sudo cp /etc/crypttab "/etc/crypttab.bak.$(date +%s)"
        
        # Clean existing entry for this UUID to avoid duplicates
        if [ -f /etc/crypttab ]; then
            sudo sed -i "s|^.*$PART_UUID.*|# &|" /etc/crypttab
        fi
        
        # Append clean config
        echo "$MAPPER_NAME UUID=$PART_UUID - luks,discard,fido2-device=auto" | sudo tee -a /etc/crypttab > /dev/null

        # --- 5. Generate Boot Image ---
        echo "⚙️  Generating boot image (Dracut)..."
        sudo dracut -f

        # --- 6. Verify ---
        echo "🔍 Verifying image..."
        if sudo lsinitrd | grep -q fido2; then
            echo "---------------------------------------------------"
            echo "🎉 SUCCESS! 'fido2' module found in boot image."
            echo "   You can reboot now. When asked for password, TOUCH YUBIKEY."
            echo "---------------------------------------------------"
        else
            echo "⚠️  WARNING: 'fido2' module missing. Check logs."
        fi
    fi
fi

```

To check if your setup was successful, run:

```bash title="Verify Dracut Image for FIDO2"
$ sudo systemd-cryptenroll /dev/nvme0n1p3 
SLOT TYPE    
   0 password
   1 fido2
$ sudo lsinitrd | grep fido2
$ cat /etc/crypttab
# <mapper_name> UUID=<uuid> - luks,discard,fido2-device=auto
```

To test the configuration, reboot your system. When prompted for the disk password during boot, simply touch your YubiKey to unlock the LUKS-encrypted partition.

!!! warning "Risky Operation"

    This process involves changing core boot components. If misconfigured, it may render your system unbootable. Always ensure you have backups of important data before proceeding.

    You may need a live USB to recover your system if something goes wrong.

## Use YubiKey to Login

To enhance your system's security further, you can also configure your Linux desktop login to use the same YubiKey for authentication. This allows you to log in by simply touching your YubiKey, providing both convenience and strong security.

You can read more about this setup [here](./Use-Yubikey-To-Login.md).
