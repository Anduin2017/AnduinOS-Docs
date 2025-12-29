# How to Manage SSH Keys with YubiKey

## 1. Initialize Key & Save to YubiKey

Generate a resident, PIN-protected Ed25519 key directly on the hardware device.

```bash title="Generate resident key"
ssh-keygen -t ed25519-sk -O resident -O application=ssh:YourHostname -C "yubikey-pin-protected"
```

## 2. Load Resident Keys

Load the keys stored inside the YubiKey into your current SSH agent (useful on new machines).

```bash title="Load keys from hardware"
ssh-add -K # Load to memory (From Yubikey)
ssh-add -L  # Verify the key is loaded

```

## 3. Trust Key on Server

Upload the public key component to your remote server's authorized list.

```bash title="Copy ID to server"
ssh-copy-id -i ~/.ssh/id_ed25519_sk.pub user@server

```

## 4. Authenticate (Clean Slate)

Clear any old keys from memory to ensure you are strictly using the YubiKey, then connect.

```bash title="Clean agent and connect"
ssh-add -D  # Remove old keys from RAM
ssh user@server
# Touch YubiKey when LED flashes

```

### 4.1 Server Hardening

Remove old keys and force public key authentication on the server side.

```bash title="1. Edit server config"
# On the server: /etc/ssh/sshd_config
PasswordAuthentication no
PubkeyAuthentication yes
AuthenticationMethods publickey

```

```bash title="2. Remove old keys"
# On the server: Edit authorized_keys
vim ~/.ssh/authorized_keys
# Delete all lines starting with 'ssh-rsa', keep only 'sk-ssh-ed25519@...'

```

## 5. Backup Strategy

**You cannot backup the private key.** It is physically impossible to export it from the secure element.

* **Strategy:** You must purchase a second YubiKey, generate a new unique key on it, and register both keys on your servers.

## 6. Git Push via SSH

First, copy your public key output and paste it into your Git provider's SSH settings (e.g., GitHub Settings -> SSH and GPG keys).

```bash title="View public key"
ssh-add -L
# Copy the output starting with 'sk-ssh-ed25519@openssh.com'

```

Then, configure the local repo to use SSH; it will utilize the YubiKey automatically.

```bash title="Set remote and push"
git remote set-url origin git@github.com:username/repo.git
git push
# Touch YubiKey when LED flashes
```

To persist the ssh session, edit `vim .ssh/config` file as:

```bash title="Persist SSH connections"
Host *
    ControlMaster auto
    ControlPath ~/.ssh/cm-%r@%h:%p
    ControlPersist 10m
```

## 7. Git Commith with SSH Key Signing

You can utilize your existing SSH Resident Key to sign Git commits. This eliminates the need for GPG software while maintaining hardware-level security.

### 7.1. Auto-configure Local Git

Run this script to bind your YubiKey to Git's signing config immediately.

```bash title="One-click configuration"
# 1. Find the resident key
KEY=$(ssh-add -L | grep "sk-" | head -n 1)

# 2. Apply config if key exists
if [ -z "$KEY" ]; then
    echo "❌ Key not found. Run 'ssh-add -K' first."
else
    git config --global gpg.format ssh
    git config --global user.signingkey "key::$KEY"
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true

    echo "✅ Configured! Copy this Public Key for GitHub:"
    echo "$KEY"
fi
```

### 7.2. Trust Key on GitHub (Crucial)

Even if you already added this key for pushing code, you must add it **again** for signing.

1. Go to **GitHub Settings** -> **SSH and GPG keys**.
2. Click **New SSH Key**.
3. **Title:** e.g., "YubiKey Signing".
4. **Key type:** Select **Signing Key** (Default is Authentication).
5. **Key:** Paste the public key output from the script above.

### 7.3. Verify

```bash title="Test signature"
git commit --allow-empty -m "Signed via YubiKey"
# Touch YubiKey when LED flashes. 
```

Run `git push` to upload the signed commit. And you can verify the signature on GitHub.

## 8. Setting Up on a New Machine

Thanks to the resident key feature, setting up a new computer is instant. You do not need to copy any files from your old machine.

1. **Insert YubiKey** into the new computer.
2. **Load Keys** into the SSH agent immediately.

```bash title="Download key stubs & load into memory"
ssh-add -K
# Enter PIN and touch YubiKey if prompted

```

3. **Persist Keys (Optional)**

If you want to save the key stubs to disk so you don't have to run `ssh-add -K` after every reboot:

```bash title="Save stubs to .ssh folder"
mkdir -p ~/.ssh && cd ~/.ssh && ssh-keygen -K
# This downloads the stub files (id_ed25519_sk_rk...) to your .ssh folder. Please note: your private key **IS** still in your Yubikey ONLY and not transfered!!!

```

4. **Setup Git (Optional)**

If you use Git signing, run the one-click configuration script from section 7.1 again.

5. **Connect to Servers** as usual; the YubiKey will handle authentication.

## 9. FAQ

* **Q: Why doesn't the terminal ask for my PIN?**
**A:** If you see the LED flashing, the PIN might be cached by your OS, or you didn't set `-O verify-required`.
* **Q: The terminal is stuck after I run `ssh`.**
**A:** SSH is waiting for you to touch the YubiKey; look for the flashing light.
* **Q: What if I lose my YubiKey?**
**A:** You must use your backup YubiKey to log in and remove the lost key's entry from `authorized_keys`.
* **Q: What if I delete my local `.ssh` folder?**
**A:** The folder will be useless for saving ssh keys. All your keys are saved in your yubikey. `ssh-add -K` imports the public key to memory. `ssh-add -L` to view the public keys.
