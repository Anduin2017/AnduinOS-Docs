# Deskmon

**Deskmon** is a preinstalled background service in **AnduinOS** that monitors the `~/Desktop` directory for changes. Its primary purpose is to automatically mark newly added `.desktop` files as trusted and executable. This simplifies the common user scenario where one places a shortcut on the desktop but is unsure how to make it runnable.

---

## Features

* Watches the `~/Desktop` folder in real-time.
* Automatically marks `.desktop` files as trusted (`chmod +x` and metadata update).
* Lightweight C binary using GLib/GIO.
* Runs as a user-level `systemd` service.

---

## Disable Deskmon

If you prefer not to use Deskmon, you can disable and remove it manually:

```bash
systemctl --user stop deskmon.service
systemctl --user disable deskmon.service
rm -f /usr/local/bin/deskmon
```

---

## Verify or Build from Source

To verify Deskmon’s integrity or build it yourself from source:

### 1. Install Dependencies

```bash
sudo apt update
sudo apt install -y libglib2.0-dev pkgconf gcc
```

### 2. Build Deskmon

You can download the original source code [from here](https://gitlab.aiursoft.cn/anduin/anduinos/-/tree/1.4/src/mods/20-deskmon-mod).

```bash
wget https://gitlab.aiursoft.cn/anduin/anduinos/-/raw/1.4/src/mods/20-deskmon-mod/deskmon.c -O deskmon.c
gcc -O2 $(pkg-config --cflags glib-2.0 gio-2.0) \
    deskmon.c -o deskmon \
    $(pkg-config --libs glib-2.0 gio-2.0)
sudo mv deskmon /usr/local/bin/deskmon
sudo chmod +x /usr/local/bin/deskmon
```

The official binary is built with the same command, so you can compare checksums to verify integrity.
