# Dual Boot AnduinOS with Windows

Before you begin, ensure you have a backup of your important data. Dual booting can lead to data loss if not done correctly.

!!! warning "Turn on Secure Boot!"

    AnduinOS supports Secure boot well. During the installation, it is very recommended to turn on Secure Boot to ensure the security of your system. If you have already installed AnduinOS without Secure Boot, you can turn on Secure Boot at any time. However, you may need to sign the kernel modules manually if you have installed third-party kernel modules.

## Two disks setup (Suggested)

If you have two separate physical disks, one for Windows and one for AnduinOS, follow these steps:

1. **Backup Data** and wipe all disks. Especially ensure the disk for AnduinOS is empty. You can do this via running:

```bash title="Wipe Disk"
sudo wipefs -a /dev/sdX
```

Replace `/dev/sdX` with the actual disk identifier for the AnduinOS disk (e.g., `/dev/sda`, `/dev/sdb`).

2. **Install Windows**: Install Windows on the first disk as you normally would. Don't mount the second disk in Windows.
3. **Install AnduinOS**: During the installation of AnduinOS, select the second disk as the installation target. Let AnduinOS take the entire disk and handle the partitioning automatically.
4. **Bootloader**: AnduinOS will automatically install the GRUB bootloader, which will detect Windows and add it to the boot menu.
5. **Enable BitLocker (Optional)**: If you want to use BitLocker on the Windows disk, you can enable it after the installation of AnduinOS.

## Single disk setup

If you have only one physical disk, follow these steps:

1. **Backup Data** Ensure you have a backup of all important data before proceeding.
2. **Install Windows**: Install Windows first. During the installation, create a partition for Windows and leave enough space for AnduinOS. Do not format the space you plan to use for AnduinOS.
3. **Turn off Fast Startup**: In Windows, go to Control Panel > Power Options > Choose what the power buttons do > Change settings that are currently unavailable, and uncheck "Turn on fast startup (recommended)". This prevents Windows from locking the disk.
4. **Turn off BitLocker**: If you have BitLocker enabled, disable it for the Windows partition.
5. **Shrink the Windows Partition**: In Windows, open Disk Management, right-click the Windows partition, and select "Shrink Volume". Shrink it to create enough space for AnduinOS (at least 20 GB is recommended).
6. **Install AnduinOS**: Boot from the AnduinOS installation media. During the installation, select the "Install alongside Windows" option. The installer will automatically resize the Windows partition and create a new partition for AnduinOS.

!!! warning "Always install Windows first!"

    Windows installer tends to overwrite the bootloader of other operating systems. Therefore, it is crucial to install Windows first before installing AnduinOS! If you have already installed AnduinOS, you may need to reinstall the GRUB bootloader after installing Windows!
