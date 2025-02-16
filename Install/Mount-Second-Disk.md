# Mount your second disk

If you have a second disk in your computer, you can mount it to your system to use it as a storage device. In this guide, we will show you how to mount your second disk to your system.

To view all the disks in your system, you can use the `lsblk` command. The `lsblk` command is a tool to list block devices. You can use the `lsblk` command to list all block devices in your system.

```bash title="List all block devices"
$ $ lsblk 
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 931.5G  0 disk 
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
└─nvme0n1p2 259:2    0   931G  0 part /
nvme1n1     259:3    0 953.9G  0 disk 
```

In the example above, we have three disks in our system: `nvme0n1`, and `nvme1n1`. To mount the second disk `nvme1n1` to `/opt/disk2`, you can follow these steps:

1. Create a mount point directory for the second disk.

```bash
sudo mkdir -p /opt/disk2
```

3. (Optional) Format the second disk.

!!! warning "Data Loss"

    Formatting the disk will lose all data on the disk. Make sure to back up your data before formatting the disk.

```bash
sudo mkfs.ext4 /dev/nvme1n1 # The second disk. Replace it with your disk name.
```

3. Mount the second disk to the mount point directory.

```bash
sudo mount /dev/nvme1n1 /opt/disk2 # /dev/nvme1n1 is the second disk. Replace it with your disk name.
```

4. Write `/etc/fsab` to mount the disk automatically on boot.

The `mount` command only mounts the disk temporarily. To mount the disk automatically on boot, you can write the disk to `/etc/fstab`.

```bash
# /dev/nvme1n1 is the second disk. Replace it with your disk name.
echo "/dev/nvme1n1 /opt/disk2 ext4 defaults 0 0" | sudo tee -a /etc/fstab
```

After rebooting your system, the second disk will be mounted to `/opt/disk2`.

To verify that the second disk is mounted, you can use the `df` command and `lsblk` command.

```bash title="List all mounted disks"
$ sudo df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
efivarfs       efivarfs  192K  160K   28K  86% /sys/firmware/efi/efivars
/dev/nvme0n1p1 vfat      511M  6.1M  505M   2% /boot/efi
/dev/nvme0n1p2 ext4      916G  417G  453G  48% /
/dev/nvme1n1   ext4      938G   28K  891G   1% /opt/disk2
```

In the example above, the second disk `nvme1n1` is mounted to `/opt/disk2`.

That's it! You have successfully mounted your second disk to your system. You can now use the second disk as a storage device.
