# Manage SSH Keys

SSH Keys are a secure way to authenticate to a server. They are a pair of cryptographic keys that can be used to authenticate to an SSH server as an alternative to password-based logins. One key is private and the other is public. When you generate an SSH key pair, you will get a private key and a public key. The private key is kept on the computer you log in from, while the public key is stored on the .ssh/authorized_keys file on all the servers you want to log in to.

## Generate SSH Key Pair

To generate an SSH key pair, you can use the `ssh-keygen` command.

```bash
ssh-keygen
```

After running the command, you will be prompted to enter a file in which to save the key. You can press Enter to save it in the default location (`~/.ssh/id_rsa`), or specify a different location. You will also be prompted to enter a passphrase to secure the private key. You can press Enter to leave it empty, or enter a passphrase.

Once the key pair is generated, you will have two files: `id_rsa` (private key) and `id_rsa.pub` (public key). The public key can be shared with others, while the private key should be kept secure.

## Copy SSH Key to Server

To add your SSH key to the SSH agent, you can use the `ssh-copy-id` command.

```bash
ssh-copy-id user@hostname
```

Replace `user` with your username and `hostname` with the IP address or domain name of the server you want to copy the key to. You will be prompted to enter your password for the server. Once the key is copied, you can log in to the server without entering a password.

After that, you can log in to the server using the following command:

```bash
ssh user@hostname
```

## Add SSH Key to Git Server

Also, you can use SSH key to authenticate git servers like GitHub, GitLab, Bitbucket, etc. by adding your public key to your account settings.

To add your SSH key to your GitHub account, you can follow these steps:

- Copy your public key to the clipboard.

```bash
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
```

- Go to your GitHub account settings.
- Click on "SSH and GPG keys" in the left sidebar.
- Click on "New SSH key".
- Paste your public key into the "Key" field.
- Click on "Add SSH key".
- Confirm the action by entering your GitHub password.
- You can now use SSH to authenticate to GitHub.

To make sure your SSH key is being used, you can test the connection to the server.

```bash
ssh git@github.com
```

## Backup SSH Keys

It is important to back up your SSH keys to prevent data loss. You can copy the `~/.ssh` directory to a secure location, such as an external drive or cloud storage.

```bash
cp -r ~/.ssh /path/to/backup
```

Make sure to keep the backup secure and up-to-date.

## Restore SSH Keys

If you need to restore your SSH keys from a backup, you can copy the `~/.ssh` directory back to your home directory.

```bash
mkdir ~/.ssh
cp -r /path/to/backup/.ssh/* ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
```

Make sure to set the correct permissions on the private key file.

## SSH to Server

To SSH to a server using a specific private key, you can use the `-i` option.

```bash
ssh -i /path/to/private_key user@hostname
```

Replace `/path/to/private_key` with the path to your private key file, `user` with your username, and `hostname` with the IP address or domain name of the server.

### Via SSH gateway

In some cases, the Server might behind a firewall or NAT, and you need to use a jump host to connect to it. You can use the `-J` option to specify a jump host.

```bash
ssh -J user@jump_host user@hostname
```

Replace `user@jump_host` with the username and hostname of the jump host, and `user@hostname` with the username and hostname of the server.

### Via HTTP proxy

In some cases, you might need to connect to a server through an HTTP proxy. You can use the `ProxyCommand` option to specify the proxy command.

```bash
ssh -o "ProxyCommand=nc -X connect -x <proxy_host>:<proxy_port> %h %p" <user>@<host>
```

Replace `<proxy_host>` and `<proxy_port>` with the hostname and port of the proxy server, `<user>` with your username, and `<host>` with the IP address or domain name of the server.

## Renew SSH Keys

This guide walks you through securely rotating your SSH key pair across remote servers.

### 1. Generate a New SSH Key Pair

```bash title="Generate a new SSH key pair with ed25519 algorithm"
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_new -C "renewed-key"
```

> `ed25519` is fast, compact, and secure. Use a meaningful comment for traceability.

### 2. Deploy the New Public Key to Servers

Run for each server:

```bash title="Copy the new public key to the remote server"
ssh-copy-id -i ~/.ssh/id_ed25519_new.pub user@server_ip
```

Or manually:

```bash title="Manually append the new public key to authorized_keys"
cat ~/.ssh/id_ed25519_new.pub | ssh user@server_ip 'cat >> ~/.ssh/authorized_keys'
```

### 3. Verify New Key Works

```bash title="Test the new SSH key"
ssh -i ~/.ssh/id_ed25519_new user@server_ip
```

If login succeeds, you're safe to remove the old key.

### 4. Make the New Key Default (Optional)

```bash title="Rename the new key to default SSH key names"
# Move away the old keys
mv ~/.ssh/id_rsa ~/.ssh/id_rsa.old
mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.old
# Rename the new key to default names
mv ~/.ssh/id_ed25519_new ~/.ssh/id_rsa
mv ~/.ssh/id_ed25519_new.pub ~/.ssh/id_rsa.pub
# chmod
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

> This lets you use `ssh user@host` without `-i`.

### 5. Remove Old Keys from Remote Servers

If you're sure the **new key is the last line**, run:

```bash title="Remove the old key from authorized_keys"
ssh user@server_ip "tail -n 1 ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp && mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys"
```

Or, safer with a backup:

```bash title="Backup and remove old key from authorized_keys"
ssh user@server_ip "cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak && tail -n 1 ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp && mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys"
```

### 6. Test Final Login

```bash title="Final test to ensure the new key works"
ssh user@server_ip
```

If it works, your new key is fully in use.

### 7. Clean Up (Optional)

If everything works:

```bash title="Remove the old private key from local machine"
rm ~/.ssh/id_rsa.old
```

Or move it to a secure archive location.
