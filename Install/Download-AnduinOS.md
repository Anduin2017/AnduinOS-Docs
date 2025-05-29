# Download AnduinOS

---

Before installing AnduinOS, you need to download the ISO file from the releases page.

[Download AnduinOS (ISO)](https://www.anduinos.com/){ .md-button .md-button--primary }

It is suggested to use [qbittorrent](https://www.qbittorrent.org/) to download the ISO file via Torrent, as it supports torrent and helps seed the file to others. You can also use other torrent clients like [Transmission](https://transmissionbt.com/) or [Deluge](https://deluge-torrent.org/).

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
