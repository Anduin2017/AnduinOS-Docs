# Debug Storage Consumption

In some cases, you may notice that your storage space is being consumed rapidly. This can be due to various reasons such as log files, cache files, or other temporary files. In this guide, we will show you how to debug storage consumption on your server.

## Understand Linux disk layout

In Linux, disks are represented as files under the `/dev` directory. You can use the `ls` command to list the contents of the `/dev` directory.

To list all the disks on your system, you can use the following command:

```bash
sudo ls /dev/
```

You can also use the `fdisk` tool to list all the disks on your system:

```bash
sudo fdisk -l
```

In Linux, all folders and files are stored under the root directory `/`. There is nothing like `D:` or `E:`. All disks are mounted under the root directory as folders. You can use the `lsblk` command to list all the block devices on your system:

```bash
sudo lsblk
```

If you unplugged a disk from your system, you will notice it disappeared from the output of the `lsblk` command and `fdisk -l` command.

## Formatting and mounting a disk

If you have a new disk that you want to use, you need to format and mount it. To format a disk, you can use the `mkfs` command. For example, to format a disk `/dev/sdb` as `ext4`, you can use the following command:

```bash
sudo mkfs.ext4 /dev/sdb
```

To mount your new disk, you need to create a mount point and mount the disk to that mount point. For example, to mount the disk `/dev/sdb` to the `/mnt/data` directory, you can use the following commands:

```bash
sudo mkdir /mnt/data
```

After creating the mount point, you can mount the disk to that mount point:

```bash
sudo mount /dev/sdb /mnt/data
```

If you want to unmount the disk, you can use the following command:

```bash
sudo umount /mnt/data
```

However, after rebooting your system, the disk will be unmounted. To mount the disk automatically after reboot, you need to add an entry to the `/etc/fstab` file. For example, to mount the disk `/dev/sdb` to the `/mnt/data` directory automatically after reboot, you can add the following entry to the `/etc/fstab` file:

```bash
sudo vim /etc/fstab
```

You need to add a new line to the `/etc/fstab` file with the following format:

```fstab
/dev/sdb /mnt/data ext4 defaults 0 0
```

The text above will tell the system to mount the disk `/dev/sdb` to the `/mnt/data` directory with the `ext4` filesystem and default options.

In Linux, best practice before writing to a disk is to check the disk mount point. You can use the `df` command to check the disk mount point. For example, to check the mount point of the `/mnt/data` directory, you can use the following command:

```bash
cd /mnt/data
df . -Th
```

If you unplugged a disk from your system, you will notice it disappeared from the output of the `df` command. However, the mount point will still be there. And you may notice an empty folder with the same name as the mount point.

So always be careful when writing to a disk. If you write to a disk that is not mounted, you will be writing to the mount point folder, which is not what you want.

## Check Disk Usage

In some cases, you might notice that your storage space is being consumed rapidly. This can be due to various reasons such as log files, cache files, or other temporary files. In this guide, we will show you how to debug storage consumption on your server.

Before starting, you need to locate the folder which you want to investigate.

```bash
cd /var/log
```

You can use the `du` command to check the disk usage of a specific folder. For example, to check the disk usage of the `/var/log` folder, you can use the following command:

```bash
sudo df . -Th
```

You can also use the `du` command to check the disk usage of a specific folder. For example, to check the disk usage of the `/var/log` folder, you can use the following command:

```bash
sudo du -d 1 -h
```

The `-d 1` option tells the `du` command to show the disk usage of the first level of the folder. The `-h` option tells the `du` command to show the disk usage in human-readable format.

```bash
sudo du -d 1 | sort -nr
```

If you want to sort the output by disk usage, you can use the `sort` command with the `-nr` option. The `-n` option tells the `sort` command to sort the output numerically, and the `-r` option tells the `sort` command to sort the output in reverse order.

And finally, if you found a folder that is consuming a lot of storage space, and you confirmed that the content inside that folder is not important, you can delete that folder using the `rm` command. For example, to delete the `/var/log/some-specific-folder` folder, you can use the following command:

```bash
sudo rm -rf /var/log/some-specific-folder
```

That's it! You now know how to debug storage consumption on your server. You can use the `du` command to check the disk usage of a specific folder and the `rm` command to delete unnecessary files and folders.
