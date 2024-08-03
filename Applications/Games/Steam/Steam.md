# Steam

Steam is a digital distribution platform developed by Valve Corporation, which offers digital rights management (DRM), multiplayer gaming, video streaming and social networking services. Steam provides the user with installation and automatic updating of games on multiple computers, and community features such as friends lists and groups, cloud saving, and in-game voice and chat functionality. The software provides a freely available application programming interface (API) called Steamworks, which developers can use to integrate many of Steam's functions into their products, including networking, matchmaking, in-game achievements, micro-transactions, and support for user-created content through Steam Workshop.

To install Steam on AnduinOS, you can run:

!!! warning "i386 architecture required"

    Enabling the i386 architecture on a 64-bit system is required to run certain 32-bit applications like Steam. This process involves adding support for 32-bit libraries, which can have implications for your system's stability and performance. Below are some potential issues you may encounter:

    Potential Issues:

    * Dependency Conflicts: Adding i386 architecture may lead to dependency conflicts where certain packages require different versions of the same library.
    * Increased Disk Usage: Installing 32-bit libraries alongside 64-bit ones will consume additional disk space.
    * System Complexity: Managing both 32-bit and 64-bit libraries can increase the complexity of system maintenance and troubleshooting.
    * Compatibility Issues: Some software or updates might not be fully compatible with the i386 architecture, leading to potential instability or broken dependencies.

    If you encounter any issues after enabling the i386 architecture, you can revert the changes by removing the i386 architecture and its associated packages. However, this process may not be straightforward and could result in further complications.

```bash title="Install Steam"
cd ~
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libc6-i386 libutempter0 xbitmaps xterm libgl1-mesa-dri:i386 libgl1:i386 -y

wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb -O steam.deb
sudo dpkg -i steam.deb
sudo apt --fix-broken install -y
rm steam.deb
```

However, after installation, you will need to log in with your Steam account to download and play games. You can also install games from the Steam store using the Steam client.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Uninstall Steam

To uninstall Steam from AnduinOS, you can run:

```bash
sudo apt purge steam-installer steam-launcher -y
sudo apt autoremove -y
```

If you also want to remove the `i386` architecture, you can run:

```bash
sudo dpkg --remove-architecture i386
sudo apt autoremove libc6-i386 libutempter0 xbitmaps xterm libgl1-mesa-dri:i386 libgl1:i386 -y
sudo apt update
```
