# Install Input Method

By default, AnduinOS uses `ibus` as the input method framework.

During the installation, the installer may installed an `ibus` input method engine for you.

For example:

* if you choose `Chinese` as the default language, the installer will install [ibus-libpinyin](https://github.com/libpinyin/ibus-libpinyin) for you.
* If you choose `Japanese` as the default language, the installer will install [ibus-anthy](https://github.com/phuang/ibus-anthy) for you.
* You can also install your own `ibus` input method engine. For example, `ibus-rime`.

The dependency graph is as follows:

```mermaid
flowchart TD
    Aos[AnduinOS] -->|calls| Fcitx(fcitx)
    Aos[AnduinOS] -->|calls| Ibs(ibus)
    Ibs -->|calls| Pin[ibus-libpinyin]
    Ibs -->|calls| Anthy[ibus-anthy]
    Ibs -->|calls| Oth["(Other ibus input methods...)"]
    Ibs -->|calls| Rime("ibus-rime (A framework)")
    Rime -->|calls| Luna[rime-data-luna-pinyin]
    Rime -->|calls| Cangjie[rime-data-cangjie]
    Rime -->|calls| Ice[iDevel/rime-ice]
    Rime -->|calls| Arime["AnduinOS-Rime (Suggested)"]

    style Arime fill:#1b3136,stroke:#00bfa5,stroke-width:2px
```

## How to install AnduinOS-Rime as the Chinese input method

??? Tip "Why doesn't AnduinOS embed Rime input method by default?"

    Rime is a powerful input method engine that supports multiple languages and input methods. It is widely used in China. However, Rime is not included in AnduinOS by default because not all users who use AnduinOS need Chinese input methods. Therefore, we recommend users who need Chinese input methods to install Rime manually.

    If you don't prefer Rime, you can use other input methods like `ibus-libpinyin`.

To install AnduinOS-Rime, first, you need to install `ibus-rime`.

```bash title="Install ibus-rime"
sudo apt install ibus-rime
```

!!! note "Log out and log back in"

    You **need** to log out and log back in to make the input method available.

Then, you can add `Rime` as the input method.

1. Log in, open `Settings`, go to `Keyboard`.
2. Click on the "+" sign under `Input sources`.
3. Select `Chinese (China)` and then `Chinese (Rime)`.

![select rime](./select-rime.png)

Or even easier, you can run the following command to add `Rime` as the input method.

```bash title="Add Rime as the input method"
dconf write /org/gnome/desktop/input-sources/mru-sources "[('xkb', 'us'), ('ibus', 'rime')]"
dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('ibus', 'rime')]"
```

To install `anduinos-rime`, you can run the following command:

```bash title="Install anduinos-rime"
zip=https://gitlab.aiursoft.cn/anduin/anduinos-rime/-/archive/master/anduinos-rime-master.zip
wget $zip -O anduinos-rime.zip && unzip anduinos-rime.zip && rm anduinos-rime.zip
rsync -Aavx --update --delete ./anduinos-rime-master/assets/ ~/.config/ibus/rime/
rm -rf anduinos-rime-master
ibus restart
ibus engine rime
echo "Please logout and login to start AnduinOS-Rime!"
```

!!! note "Log out and log back in"

    You **need** to log out and log back in to make the input method available.

Now, you have set `AnduinOS-Rime` as your input method.

![using-rime](./using-rime.png)

To switch between input methods, you can press `Windows + Space`.

!!! note "You can uninstall ibus-libpinyin"

    It is very suggested to uninstall the `ibus-libpinyin` package if you are using `AnduinOS-Rime`.

    ```bash title="Uninstall ibus-libpinyin"
    sudo apt autoremove ibus-libpinyin --purge
    ```
