# Download AnduinOS

---

Before installing AnduinOS, you need to download the ISO file from the releases page.

[Download AnduinOS (ISO)](https://www.anduinos.com/){ .md-button .md-button--primary }

It is suggested to use aria2 to download the ISO file. You can find the torrent file on the releases page.

You can use a BitTorrent client to download the ISO file. It is suggested to use `aria2` to download the ISO file.

```bash title="Download ISO file using aria2"
cd ~/Downloads
sudo apt update
sudo apt install aria2
wget https://download.anduinos.com/AnduinOS.some-version.torrent -O AnduinOS.some-version.torrent
aria2c AnduinOS.some-version.torrent
```

For Windows users, you can use `qBittorrent` to download the ISO file.

Please download [qBittorrent](https://www.qbittorrent.org/download.php) and install it on your Windows machine. Then, open the torrent file with `qBittorrent` to start downloading the ISO file.

## Verify the ISO sha256 checksum

After downloading the ISO file, you should verify the integrity of the file to ensure that it has not been tampered with.

To verify the ISO file, you can use the `sha256sum` command on Linux or macOS, or the `7-Zip` software on Windows.

```bash title="Verify ISO file"
sha256sum ./AnduinOS.iso
```

Please compare the output of the `sha256sum` command with the checksum provided on the releases page (File ends with `.sha256`). If the checksums match, the ISO file is valid and has not been tampered with.

## FAQ: What's the difference between different language versions?

For example, you may see iso versions like this:

* AnduinOS-0.2.2-beta-en_US-2408250718.iso
* AnduinOS-0.2.2-beta-zh_CN-2408250659.iso

There are a few differences between different language versions:

* Installed language packs are different. For example, `zh_CN` version will have Chinese language packs installed by default.
* Installed input methods are different. For example, `zh_CN` version will have Chinese input methods installed by default.
* Environment variables are different. Including: `LANG`, `LANGUAGE`.
* Timezone is different. `zh_CN` version will use `Asia/Shanghai` by default.
* Default apt mirror is different. `zh_CN` version will use Chinese mirrors by default.

!!! note "You can still switch the language before or after the installation"

    You can still switch the language before or after the installation. The only difference is the default settings.

    For example, if you downloaded `en_US` version but you want to use Chinese language, you can install Chinese language packs and input methods after the installation. Or you can just select Chinese language during the installation process. Internet connection is required.

    To switch the language, please refer to the [Change system language](./Switch-To-Your-Language.md) guide.
