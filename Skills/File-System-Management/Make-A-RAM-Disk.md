# Make a RAM disk

In AnduinOS, sometimes you might need a RAM disk to store temporary files. A RAM disk is a portion of your RAM that is used as a disk. It is faster than a physical disk because it is stored in your RAM. In this guide, we will show you how to make a RAM disk on your server.

To make a RAM disk on your server, follow these steps:

```bash
sudo mkdir /mnt/ramdisk
sudo mount -t tmpfs -o size=512M tmpfs /mnt/ramdisk
```

In the above commands, we are creating a directory `/mnt/ramdisk` and mounting a `tmpfs` filesystem to it. The `size=512M` option specifies the size of the RAM disk. You can change the size according to your requirements.

However, after rebooting your system, the RAM disk will be unmounted. To mount the RAM disk automatically after reboot, you need to add an entry to the `/etc/fstab` file. For example, to mount the RAM disk to the `/mnt/ramdisk` directory automatically after reboot, you can add the following entry to the `/etc/fstab` file:

```bash
sudo vim /etc/fstab
```

You need to add a new line to the `/etc/fstab` file with the following format:

```fstab
tmpfs /mnt/ramdisk tmpfs size=512M 0 0
```

The text above will tell the system to mount the RAM disk to the `/mnt/ramdisk` directory with the `tmpfs` filesystem and a size of `512M`.

After adding the entry to the `/etc/fstab` file, you can mount the RAM disk by running the following command:

```bash
sudo mount -a
```

You can check if the RAM disk is mounted by running the following command:

```bash
cd /mnt/ramdisk
df -h
```

You should see the RAM disk mounted on the `/mnt/ramdisk` directory.

That's it! You have successfully created a RAM disk on your server. You can now use the RAM disk to store temporary files.
