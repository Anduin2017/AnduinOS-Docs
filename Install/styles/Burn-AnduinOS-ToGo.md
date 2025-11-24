## AnduinOS Live with persistence (AnduinOS ToGo)

Starting from **AnduinOS 1.4**, the ISO image includes a "AnduinOS ToGo" feature. This allows you to use the installation media as a fully persistent portable operating system. You can install packages (e.g., Rust, compilers), change system configurations, and save files, all of which will be retained on the USB drive after a reboot.

This is ideal for carrying your development environment or personal desktop configuration between different computers.

### Requirements

  * **ISO Version**: AnduinOS 1.4 or later.
  * **USB Drive**: A flash drive with at least **8GB** of capacity. (For a comfortable experience with installed software, 32GB or larger is recommended).

### Creation Steps

The process creates a hybrid partition layout that supports persistence automatically.

1.  **Burn the ISO**: Follow the [Bare-mental Installation](https://www.google.com/search?q=%23bare-mental-installation---make-a-usb-installer) steps above to burn the ISO to your USB drive.

!!! warning "Critical: Use `dd` mode"

    You **must** use the `dd` mode (in Rufus) or the `dd` command (in Linux) to burn the image.

Standard ISO copying methods (like "ISO mode" in Rufus or simple file copying) will **not** create the necessary partition structure for the persistence overlay data to be saved.

2.  **Boot**: Insert the USB drive into the target computer and boot from it.
3.  **Select Mode**: In the GRUB boot menu, do not select the default "Try AnduinOS" or "Install" option. Instead, select **AnduinOS ToGo**.

The system will boot, mount the persistent partition on the USB stick, and overlay it onto the root filesystem. Any changes you make will now be written back to the USB drive.

### Verifying Storage Space

Since USB drives typically have less storage than internal hard drives, and the persistence partition shares space with the ISO image itself, it is highly recommended to check your available disk space immediately after booting.

Open a terminal and run:

```bash title="Check available persistent storage"
df -h /
```

Ensure you have enough `Avail` space before performing large updates or compiling large projects.

-----

**Tip:** If you require a more permanent solution or better I/O performance for a portable drive, you can also use the graphical installer within the Live environment to install AnduinOS fully onto *another* high-speed USB drive (as mentioned in community discussions), but the **AnduinOS ToGo** mode described above is the fastest way to get started with a single stick.
