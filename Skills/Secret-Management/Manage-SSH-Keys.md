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
