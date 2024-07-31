# Postman

Postman is a collaboration platform for API development. Postman's features simplify each step of building an API and streamline collaboration so you can create better APIs—faster.

To install Postman on AnduinOS, you can run:

```bash
wget https://dl.pstmn.io/download/latest/linux_64 -O postman-linux-x64.tar.gz
sudo tar -xzf postman-linux-x64.tar.gz -C /opt
rm postman-linux-x64.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman
echo "[Desktop Entry]
Name=Postman
Comment=API Development Platform
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=System;Development;API;" | sudo tee /usr/share/applications/postman.desktop
```

Then, you can run Postman by typing `postman` in your terminal or searching for Postman in your application menu.
