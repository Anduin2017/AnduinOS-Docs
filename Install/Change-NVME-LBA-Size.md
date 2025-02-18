# Change NVME LBA Size

Since we are about to deploy AnduinOS on a machine, and you may have a NVME SSD with a 4K LBA size, we need to change the LBA size to 512 bytes to make it compatible with AnduinOS.

!!! tip "This is fully optional"

    If you are not sure about the LBA size of your NVME SSD, you can skip this step. AnduinOS will work fine with both 4K and 512 bytes LBA size. This step is only for performance improvement.

This guide will walk you through changing your NVMe drive to use a 4K (4096 bytes) Logical Block Addressing (LBA) format. **Please note that this procedure will erase all data on the drive.** Make sure to back up any important information beforehand.

---

## 1. Install Required Tools

First install `nvme-cli` (and update your package list if needed):

```bash
sudo apt update
sudo apt install nvme-cli
```

---

## 2. Identify Your NVMe Device

**List all drives** to identify your NVMe device:

```bash
sudo fdisk -l
```

**Confirm your NVMe device** (often named `/dev/nvme0n1`, but could differ). You can also run:

```bash
nvme list
```

This should display details about your NVMe devices.

**Check current LBA formats**:

```bash title="Check LBA Formats"
nvme id-ns /dev/nvme0n1 --human-readable
```

Look for lines like:

```bash
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x2 Good (in use)
LBA Format  1 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0x1 Better 
```

For some disks, it may show that not better format is available. It's only suggested to continue if you see a better format available.

In the example above, the drive has two LBA formats available. We want the 4K format, usually shown as `lbaf=1`.

---

## 3. Perform the Format Operation

**Warning:** The following command **destroys all data** on the NVMe device. Double-check the device name and ensure you have a full backup.

1. **Execute the format** command:

!!! warning "Backup your data before running this command!"

    Formatting the drive will erase all data. Make sure to back up any important information beforehand.

    And do NOT use `dd` to backup the drive because changing the LBA size will make the backup unusable.

```bash
sudo nvme format /dev/nvme0n1 --lbaf=1 --ses=0
```

- `--lbaf=1` selects the 4K LBA format.
- `--ses=0` performs a format without secure erase (faster). You can use `--ses=1` for a more thorough erase if desired.

1. Wait for the format to complete. The device should now be in 4K mode internally.

---

## 4. Recreate Partitions and Filesystems (Using `fdisk`)

After formatting, the drive is blank and needs partitioning and a filesystem. Here’s how to do it with `fdisk`:

1. **Open fdisk on the device**:

```bash
sudo fdisk /dev/nvme0n1
```

2. **Create a new GPT partition table**:
    - Press `g` to create a new GPT partition table.

3. **Create a new partition**:
    - Press `n` to add a new partition.
    - Accept default values (or adjust if you want a smaller partition).

4. **(Optional) Review partition layout**:
    - Press `p` to print the current partition table.

5. **Write the partition changes**:
    - Press `w` to write and exit `fdisk`.

6. **Create a filesystem** on the newly created partition (example: ext4):

    ```bash
    sudo mkfs.ext4 /dev/nvme0n1p1
    ```

Your disk now has a single ext4 partition aligned and ready for use.

---

## 5. Verify the Result

Verify that your NVMe now uses a 4K LBA format:

```bash
nvme id-ns /dev/nvme0n1 --human-readable
```

Look for the active LBA Format:

```
LBA Format  1 : Metadata Size: 0 bytes - Data Size: 4096 bytes ...
```

If you see **4096 bytes** as the data size, then the drive is using 4K blocks.

---

## 6. Summary

- **Backup** all important data beforehand.
- Use `nvme format` with the correct `--lbaf` option to switch to a 4K LBA format.
- Re-partition the drive using `fdisk`, selecting GPT and creating at least one partition.
- Format the partition with a suitable filesystem (e.g., ext4, xfs, etc.).
- Confirm with `nvme id-ns` that the LBA format is set to 4096 bytes.

You now have your NVMe device configured to 4K LBA, which can provide better performance for many workloads.