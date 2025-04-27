# Use mdadm to Build a RAID Array

## What is RAID?

* **RAID0 (Striping)**  
  Data is striped across multiple disks, providing high read/write performance. However, there is no data redundancy. If one disk fails, all data will be lost.

* **RAID1 (Mirroring)**  
  Data is mirrored across multiple disks, ensuring high data security. However, the available storage capacity is limited to the size of a single disk.

* **RAID5 (Distributed Parity)**  
  Requires at least three disks. Data and parity information are distributed across all disks, balancing performance and redundancy. It can tolerate the failure of one disk.

* **RAID6 (Double Parity)**  
  Similar to RAID5 but uses double parity, allowing it to tolerate simultaneous failures of two disks. This is ideal for scenarios requiring higher data reliability.

* **RAID10 (Mirroring + Striping)**  
  Combines the benefits of RAID0 and RAID1, offering both performance improvements and redundancy protection. It requires at least four disks.

!!! warning "Backup even with RAID"

    RAID provides fault tolerance, but it is not a substitute for regular backups. Always maintain a backup strategy to protect your data.

## 1. Install mdadm

Ensure your system's software package information is up to date and install the mdadm tool:

```bash title="Install mdadm"
sudo apt update
sudo apt install mdadm
```

During installation, the system may prompt you to configure mdadm according to your actual needs.

## 2. Initialize a RAID Array

Assuming you have three disks (e.g., `/dev/sdb`, `/dev/sdc`, `/dev/sdd`), let's create a RAID5 array as an example. You can adjust the parameters based on your requirements:

```bash title="Create RAID Array"
sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd
```

* Replace `/dev/md0` with the desired name of your RAID array.
* Use `--level=5` to specify RAID5. You can change this to other levels like `--level=0`, `--level=1`, or `--level=6` as needed.

## 3. Check the Creation Progress

You can monitor the progress of the RAID array creation using the following command:

```bash title="Monitor RAID Array Creation"
watch cat /proc/mdstat
```

This will display real-time information about the RAID array, including its status and progress. The output may look like this:

```
Personalities : [raid6] [raid5] [raid4]
md0 : active raid5 sdd[3] sdc[2] sdb[1]
      976761600 blocks super 1.2 level 5, 512k chunk
      resyncing: 25% done
```

## 4. Persistent Configuration

To ensure the RAID array persists after reboot, add it to `/etc/mdadm/mdadm.conf`:

```bash title="Add RAID Configuration"
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
```

This will automatically detect and assemble your RAID array during boot.

## 5. Format and Mount the RAID Array

After creating the RAID array, you can format it with a file system (e.g., ext4) and mount it:

1. Format the RAID array:
   
   ```bash title="Format RAID Array"
   sudo mkfs.ext4 /dev/md0
   ```

2. Create a mount point:
   
   ```bash title="Create Mount Point"
   sudo mkdir -p /mnt/raid
   ```

3. Mount the RAID array:
   
   ```bash title="Mount RAID Array"
   sudo mount /dev/md0 /mnt/raid
   ```

4. Optional: Add an entry to `/etc/fstab` for automatic mounting at boot:
   
   ```bash title="Add Entry to /etc/fstab"
   echo "/dev/md0 /mnt/raid ext4 defaults 0 2" | sudo tee -a /etc/fstab
   ```

That's it! You have successfully used **mdadm** to build a RAID array and completed the entire process, from installation to initialization, monitoring progress, formatting, and mounting. By choosing the appropriate RAID level based on your needs, you can achieve a balance between performance and data security.

## 6. Transfer the RAID Array to Another Machine

In some cases you may need to migrate an existing RAID array to a new host. The steps below show how to safely stop the array on the source machine and reassemble it on the destination.

!!! warning "Ensure Data Safety During Migration"
    
    Always unmount and stop the array cleanly before moving disks. Make sure you have a current backup in case of metadata corruption.

### 6.1 Stop and Unmount on the Source Machine

1. Unmount the array:
   ```bash title="Unmount RAID Array"
   sudo umount /mnt/raid
   ```
2. Stop the array so metadata is written and devices freed:
   ```bash title="Stop RAID Array"
   sudo mdadm --stop /dev/md0
   ```

### 6.2 Prepare the Destination Machine

1. Install `mdadm` if not already present:
   ```bash title="Install mdadm on Destination"
   sudo apt update
   sudo apt install mdadm
   ```
2. Connect the member disks (or disk partitions) in any available SATA/NVMe slots. Confirm they appear under `/dev`:
   ```bash title="List Available Disks"
   lsblk
   ```

### 6.3 Reassemble the Array on the Destination

1. Scan and assemble all recognized arrays:
   ```bash title="Auto-assemble RAID Arrays"
   sudo mdadm --assemble --scan
   ```
2. (Optional) If the array does not assemble automatically, specify member devices explicitly:
   ```bash title="Explicitly Assemble md0"
   sudo mdadm --assemble /dev/md0 /dev/sdX /dev/sdY [...other devices]
   ```

3. Verify the assembly:
   ```bash title="Check RAID Status"
   cat /proc/mdstat
   sudo mdadm --detail /dev/md0
   ```

### 6.4 Persist Configuration on the New Host

1. Append the array definition to `mdadm.conf` so it assembles at boot:
   ```bash title="Add to mdadm.conf"
   sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
   sudo update-initramfs -u
   ```

2. Add an `/etc/fstab` entry for automatic mounting:
   ```bash title="Update /etc/fstab"
   echo "/dev/md0 /mnt/raid ext4 defaults 0 2" | sudo tee -a /etc/fstab
   ```

### 6.5 Mount and Verify Data

1. Create (or reuse) the mount point:
   ```bash title="Create Mount Point"
   sudo mkdir -p /mnt/raid
   ```
2. Mount the array:
   ```bash title="Mount RAID Array"
   sudo mount /dev/md0 /mnt/raid
   ```
3. Confirm data integrity:
   ```bash title="Verify Contents"
   ls -l /mnt/raid
   df -h /mnt/raid
   ```

---

With these steps, your RAID array will be safely migrated and available on the new machine, preserving both performance and redundancy characteristics.