# Backup and Restore

It is suggested to backup your data regularly to prevent data loss. This can be done by copying the data to an external storage device or to a cloud storage service.

## Locate the backup device

Before backing up your data, you should add an external backup device. This can be an external hard drive, a USB flash drive, or a network-attached storage (NAS) device. You can also use a cloud storage service like Google Drive, Dropbox, or OneDrive.

For example, if you attached a new USB flash drive to your computer, you can find the device name by running the following command:

```bash
sudo fdisk -l
```

The device name will be something like `/dev/sdb1`. You can use this device name to mount the USB flash drive.

For example, to mount the USB flash drive to the `/mnt/backup` directory, you can run:

```bash
sudo mount /dev/sdb1 /mnt/backup
```

You can verify that the USB flash drive is mounted by running:

```bash
cd /mnt/backup
df . -Th
```

## Backup home directory

To backup your home directory, you can use the `rsync` command. The following command will sync your home directory to the backup directory:

```bash
sudo rsync -Aavx --update --delete /home/$USER /mnt/backup
```

This command is cumulative, and incremental. You can run this command multiple times, and it will only copy the changes since the last run.

To restore your home directory from the backup, you can run with reverse source and destination:

```bash
sudo rsync -Aavx --update --delete /mnt/backup/$USER /home
```

## Backup dconf

`dconf` is a low-level configuration system that is used by the GNOME desktop environment. It contains data including:

* Wallpaper settings
* Theme settings
* Icons settings
* Fonts settings
* Start menu settings
* Taskbar settings
* Gnome extensions settings
* Gnome applications settings

To backup your dconf settings, you can use the `dconf dump` command. The following command will dump your dconf settings to a file:

```bash
dconf dump / > /mnt/backup/dconf-settings
```

To restore your dconf settings from the backup, you can use the `dconf load` command:

```bash
dconf load / < /mnt/backup/dconf-settings
```

## Backup /etc directory

The `/etc` directory contains system-wide configuration files. To backup the `/etc` directory, you can use the `tar` command. The following command will create a compressed archive of the `/etc` directory:

```bash
sudo tar -czvf /mnt/backup/etc-backup.tar.gz /etc
```

To restore the `/etc` directory from the backup, you can run:

```bash
sudo tar -xzvf /mnt/backup/etc-backup.tar.gz -C /
```

## Automate backup

You can automate the backup process by creating a cron job. For example, to backup your home directory every day at 2:00 AM, you can run:

```bash title="Setup automatic backup at 2:00 AM"
echo "
#!/bin/bash
DEVICE=/dev/sda
if [ -e \$DEVICE ]; then
    sudo mkdir -p /mnt/backup
    sudo mount \$DEVICE /mnt/backup
    
    sudo rsync -Aavx --delete --update /home/$USER /mnt/backup/
    sudo umount /mnt/backup
else
    echo \"No \$DEVICE, skipping backup...\"
    DATE=\$(date +'%Y-%m-%d-%H-%M-%S')
    echo \"On \$DATE, no \$DEVICE, backup failed\" | sudo tee -a /etc/motd
    exit 1
fi
" | sudo tee /usr/local/bin/backup.sh
sudo chmod +x /usr/local/bin/backup.sh
(crontab -l ; echo "0 2 * * * /usr/local/bin/backup.sh") | crontab -
```
