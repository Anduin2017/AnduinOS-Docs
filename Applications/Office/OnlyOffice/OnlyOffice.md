# OnlyOffice

OnlyOffice is a free and open-source office suite that allows you to create, edit, and collaborate on documents, spreadsheets, and presentations. It is available for Windows, macOS, and Linux.

## Flatpak install (Recommended)

You can install OnlyOffice via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub org.onlyoffice.desktopeditors
```

## System install

To install OnlyOffice on Anduin, you can use the following command:

```bash title="Install OnlyOffice"
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

sudo apt-get update
sudo apt-get -y install onlyoffice-desktopeditors
```

That's it! You can now run OnlyOffice from your applications menu.