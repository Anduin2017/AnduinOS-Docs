# Remove Duplicate Apt Source

In some cases, you may have duplicate entries in your apt sources list. This can cause warnings when you run `apt update`. This guide will show you how to remove duplicate entries from your apt sources list.

```bash
W: Target Packages (main/binary-amd64/Packages) is configured multiple times in /etc/apt/sources.list.d/google-earth-pro.list:3 and /etc/apt/sources.list.d/google.list:1
W: Target Packages (main/binary-all/Packages) is configured multiple times in /etc/apt/sources.list.d/google-earth-pro.list:3 and /etc/apt/sources.list.d/google.list:1
W: Target Translations (main/i18n/Translation-en_US) is configured multiple times in /etc/apt/sources.list.d/google-earth-pro.list:3 and /etc/apt/sources.list.d/google.list:1
```

To fix this issue, you need to edit the apt sources list and remove the duplicate entries.

Here's a quick way to remove duplicate entries from your apt sources list. You can use the `aptsources-cleanup` script to remove duplicate entries from your apt sources list.

Open a terminal and run the following commands:

```bash
sudo apt install python3-apt python3-regex
wget https://github.com/davidfoerster/aptsources-cleanup/releases/download/v0.1.7.5.2/aptsources-cleanup.pyz
chmod +x aptsources-cleanup.pyz
sudo bash -c "echo all | ./aptsources-cleanup.pyz  --yes"
rm aptsources-cleanup.pyz
```

That's it! The duplicate entries in your apt sources list should now be removed. You can run `apt update` to verify that the warnings are gone.
