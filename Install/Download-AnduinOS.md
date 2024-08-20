# Download AnduinOS

---

Before installing AnduinOS, you need to download the ISO file from the releases page.

[Download AnduinOS (ISO)](https://download.anduinos.com/){ .md-button .md-button--primary }

It is suggested to use aria2 to download the ISO file. You can find the torrent file on the releases page.

## Download the torrent file

<!-- https://download.anduinos.com/AnduinOS.latest.torrent -->

To download the torrent file, click the link below:

[Download AnduinOS (Torrent)](https://download.anduinos.com/AnduinOS.latest.torrent){ .md-button .md-button--primary }

You can use a BitTorrent client to download the ISO file. It is suggested to use `aria2` to download the ISO file.

```bash title="Download ISO file using aria2"
cd ~/Downloads
sudo apt update
sudo apt install aria2
wget https://download.anduinos.com/AnduinOS.latest.torrent -O AnduinOS.latest.torrent
aria2c -x 16 -s 16 AnduinOS.latest.torrent
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
