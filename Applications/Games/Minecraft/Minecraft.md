# Minecraft

Minecraft is a sandbox game that allows players to build and destroy blocks in a 3D world. The game has two main modes: survival and creative. In survival mode, players must gather resources and build structures to survive. In creative mode, players have unlimited resources and can build whatever they want. The game also has a multiplayer mode, where players can join servers and play with others.

To install Minecraft on AnduinOS, you can run:

```bash
wget https://launcher.mojang.com/download/Minecraft.deb -O /tmp/minecraft.deb
sudo dpkg -i /tmp/minecraft.deb
rm /tmp/minecraft.deb
```

However, that only installs the launcher. You will need to log in with your Microsoft account to download and play the game.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
