# Use Bcache in AnduinOS

This document is intended to share comprehensive experience in using bcache to build a “large capacity backing device + high-speed cache” solution. It covers everything from installing the tools and initializing devices, to performance tuning, safely removing the cache device without service disruption, migrating the backing device to another machine, and troubleshooting common issues.

---

## Table of Contents

- [Use Bcache in AnduinOS](#use-bcache-in-anduinos)
  - [Table of Contents](#table-of-contents)
  - [Installing bcache Tools](#installing-bcache-tools)
  - [Configuring and Formatting the Backing Device](#configuring-and-formatting-the-backing-device)
  - [Adding a Cache Device to the Backing Device](#adding-a-cache-device-to-the-backing-device)
  - [Viewing Performance Information of the Backing and Cache Devices](#viewing-performance-information-of-the-backing-and-cache-devices)
  - [Performance Tuning](#performance-tuning)
  - [Safely Removing the Cache Device Without Affecting Services](#safely-removing-the-cache-device-without-affecting-services)
  - [Migrating the Backing Device to Another Machine and Mounting](#migrating-the-backing-device-to-another-machine-and-mounting)
  - [Common Issue Troubleshooting](#common-issue-troubleshooting)
    - [1. `wipefs` Reports “Device or resource busy”](#1-wipefs-reports-device-or-resource-busy)
    - [2. bcache Device Not Showing Up in fdisk](#2-bcache-device-not-showing-up-in-fdisk)
    - [3. Cache Device Unexpectedly Detaches or Fails](#3-cache-device-unexpectedly-detaches-or-fails)
    - [4. Data Risks in Writeback Mode](#4-data-risks-in-writeback-mode)
  - [Conclusion](#conclusion)

---

## Installing bcache Tools

On AnduinOS, **bcache-tools** are available in the official repositories. To install them, update the package list and run the following commands:

```bash title="Install bcache-tools"
sudo apt update
sudo apt install bcache-tools
```

> **Note:**  
> If your kernel is older, ensure that it was compiled with bcache support or consider upgrading to a newer kernel version.

---

## Configuring and Formatting the Backing Device

The backing device is responsible for storing the actual data. Before using it, make sure to secure your data by backing it up and clearing any existing signatures or partition information.

1. **Clear Existing Signatures**

   ```bash title="Clear Existing Signatures"
   sudo wipefs -a /dev/sda
   ```

!!! warning "Backup Data!"

    Ensure that any important data on `/dev/sda` is backed up or no longer needed before proceeding.

2. **Initialize the Device as a bcache Backing Device**

   ```bash title="Initialize as a bcache Backing Device"
   sudo make-bcache -B /dev/sda
   ```

   This command will create the corresponding bcache backing device (for example, `/dev/bcache0`). If the device does not immediately appear, try loading the kernel module:

   ```bash title="Load the Kernel Module"
   sudo modprobe bcache
   ```

3. **Format and Mount the Backing Device**

   ```bash title="Format and Mount the Backing Device"
   sudo mkfs.ext4 /dev/bcache0
   sudo mkdir -p /mnt/bcache
   sudo mount /dev/bcache0 /mnt/bcache
   ```

---

## Adding a Cache Device to the Backing Device

Using a high-speed device (such as an NVMe SSD) as a cache can significantly improve I/O performance. Follow these steps:

1. **Clean the Cache Device**

   Assuming your cache device is `/dev/nvme2n1`, first ensure it is not mounted or in use:

   ```bash title="Clean the Cache Device"
   sudo umount /dev/nvme2n1 2>/dev/null
   sudo wipefs -a /dev/nvme2n1
   ```

2. **Initialize the Device as a bcache Cache**

   Based on the physical parameters of the device (for example, block size and bucket size), initialize it as a cache. In this example, we use a 512B block and a 4M bucket (adjust these parameters based on your actual device characteristics):

   ```bash title="Initialize as a bcache Cache"
   sudo make-bcache --block 512 --bucket 4M -C /dev/nvme2n1
   ```

3. **Obtain the Cache Device UUID**

   Use the following command to view the bcache superblock information. Pay attention to the `cset.uuid` or `dev.uuid` field:

   ```bash title="Obtain the Cache Device UUID"
   sudo bcache-super-show /dev/nvme2n1
   ```

4. **Attach the Cache Device to the Backing Device**

   Assuming `/dev/bcache0` is your backing device, attach the cache using the obtained cache UUID:

   ```bash title="Attach the Cache Device"
   echo "<cache_set_uuid>" | sudo tee /sys/block/bcache0/bcache/attach
   ```

   After attaching, you can confirm the cache is properly added by checking the sysfs files:

   ```bash title="Check Cache Status"
   cat /sys/block/bcache0/bcache/cache_mode
   cat /sys/block/bcache0/bcache/state
   ```

---

## Viewing Performance Information of the Backing and Cache Devices

Bcache provides detailed runtime information via sysfs. Here are some common methods for checking the status and performance:

1. **Backing Device Status and Mode**

   ```bash title="View Backing Device Status"
   # View current cache mode (writethrough / writeback / writearound)
   cat /sys/block/bcache0/bcache/cache_mode

   # View current status, e.g., whether dirty data exists, run state, etc.
   cat /sys/block/bcache0/bcache/state
   cat /sys/block/bcache0/bcache/dirty_data

   # Check if writeback mode is enabled
   cat /sys/block/bcache0/bcache/writeback_running
   ```

2. **Cache Statistics**

   Detailed statistics for the cache device are available under `/sys/block/bcache0/bcache/cache/`. For example:

   ```bash title="View Cache Statistics"
   ls -l /sys/block/bcache0/bcache/cache
   # Example:
   cat /sys/block/bcache0/bcache/cache/stats_day/cache_hit_ratio
   cat /sys/block/bcache0/bcache/cache/stats_day/cache_hits
   cat /sys/block/bcache0/bcache/cache/stats_day/cache_misses
   ```

3. **Monitor I/O with System Tools**

   Use tools such as `iostat` or `dstat` to monitor real-time I/O performance:

   ```bash title="Monitor I/O Performance"
   sudo apt install pcp
   sudo dstat -D sda,nvme1n1,nvme0n1
   ```

---

## Performance Tuning

Depending on your workload and device characteristics, you can adjust various sysfs parameters to optimize performance.

1. **Switching Cache Modes**

   - **Writethrough** mode writes data directly to the backing device, offering lower risk but potentially limited write performance.  
   - **Writeback** mode allows data to be cached first on the cache device before being written to the backing device, which can greatly improve performance but poses a short-term data loss risk if the cache fails.

   To switch the cache mode to writeback:

   ```bash title="Switch to Writeback Mode"
   echo writeback | sudo tee /sys/block/bcache0/bcache/cache_mode
   ```

2. **Adjusting Sequential I/O Threshold**

   The `sequential_cutoff` parameter is used to distinguish between random and sequential I/O. Lowering this value may cause sequential I/O to bypass the cache and access the backing device directly, reducing cache fragmentation:

   ```bash title="Adjust Sequential I/O Threshold"
   echo 0 | sudo tee /sys/block/bcache0/bcache/sequential_cutoff
   ```

3. **Tuning the Writeback Threshold**

   The `writeback_percent` parameter controls the allowed percentage of dirty data. Setting it too high may lead to a large buildup of dirty data, while setting it too low could impact performance. Adjust this value based on your workload:

   ```bash title="Tune the Writeback Threshold"
   echo 50 | sudo tee /sys/block/bcache0/bcache/writeback_percent
   ```

4. **Other Tuning Recommendations**

   - Adjust the `--bucket` parameter according to your hardware’s erase block size.
   - Tweak readahead settings to further improve read performance.
   - It is recommended to make adjustments during periods of low load and monitor the changes with the provided statistics.

---

## Safely Removing the Cache Device Without Affecting Services

In some scenarios (e.g., replacing a faulty cache or upgrading firmware), you might need to remove the cache device while the system is running or before a shutdown.

1. **Gracefully Unmount the Cache Device**

   Use the detach command provided by bcache to remove the cache from the backing device. This operation will transition the backing device into a “no cache” state:

   ```bash title="Detach the Cache Device"
   echo "<cache_set_uuid>" | sudo tee /sys/block/bcache0/bcache/detach
   ```

   Verify the state of the backing device:

   ```bash title="Check Backing Device Status"
   cat /sys/block/bcache0/bcache/state
   # The expected output should be "no cache"
   ```

2. **Notes**

   - Before detaching, ensure that all dirty data has been flushed to the backing device by checking the `dirty_data` status.
   - In writethrough mode the impact on services is minimal; however, in writeback mode, perform a risk assessment before proceeding.

---

## Migrating the Backing Device to Another Machine and Mounting

Since the actual data is stored on the backing device (for example, `/dev/sda`), you can migrate this device to another machine and continue to use bcache.

1. **Final Data Synchronization on the Original Machine**

   Before migration, ensure that services stop writing to the device and perform a final rsync:

   ```bash title="Final Data Synchronization"
   sudo rsync -Aavx --update --delete /swarm-vol/ /mnt/bcache/
   ```

2. **Unmount and Disconnect the Backing Device**

   After stopping the services, unmount the bcache mount point:

   ```bash title="Unmount the Backing Device"
   sudo umount /swarm-vol
   ```

3. **Register and Mount the Backing Device on the Target Machine**

   On the new machine:

   - Install bcache-tools and load the kernel module:

     ```bash title="Install bcache-tools"
     sudo apt update
     sudo apt install bcache-tools
     sudo modprobe bcache
     ```

   - If the backing device is not recognized automatically, manually register it (using the actual backing device UUID):

     ```bash title="Register the Backing Device"
     sudo bcache-super-show /dev/sda
     echo "<backing_uuid>" | sudo tee /sys/fs/bcache/register
     ```

   - Mount the device (assuming it still appears as `/dev/bcache0`):

     ```bash title="Mount the Backing Device"
     sudo mount /dev/bcache0 /swarm-vol
     ```

??? tip "Update the `/etc/fstab` Entry"

    Update the `/etc/fstab` entry to reflect the new device path and ensure that the initramfs loads the bcache module or that the appropriate udev rules are in place.

---

## Common Issue Troubleshooting

### 1. `wipefs` Reports “Device or resource busy”

**Symptoms:**  
When running `wipefs -a /dev/nvme1n1`, you receive the error “Device or resource busy.”

**Resolution Steps:**

- **Check if the Device Is Mounted:**

  ```bash title="Check if the Device Is Mounted"
  mount | grep /dev/nvme1n1
  ```

  If the device is mounted, unmount it:

  ```bash title="Unmount the Device"
  sudo umount /dev/nvme1n1
  ```

- **Check for Active Partitions:**

  ```bash title="Check for Active Partitions"
  lsblk
  ```

  If any partitions are in use, unmount each one:

  ```bash title="Unmount Partitions"
  sudo umount /dev/nvme1n1pX   # Replace X with the partition number
  ```

- **Check for bcache Association:**

  ```bash title="Check for bcache Association"
  sudo bcache-super-show /dev/nvme1n1
  ```

  If the device is already part of a bcache setup, stop the related bcache service (e.g., write a 1 to `/sys/block/bcacheX/bcache/stop` for the appropriate bcache device) before running `wipefs`.

- **Check for Swap Usage:**

  ```bash title="Check for Swap Usage"
  cat /proc/swaps
  sudo swapoff /dev/nvme1n1
  ```

- **Check for Open File Descriptors:**

  ```bash title="Check for Open File Descriptors"
  sudo lsof | grep /dev/nvme1n1
  ```

  Kill any processes if necessary:

  ```bash title="Kill Processes"
  sudo kill -9 <PID>
  ```

After completing these steps, try again:

```bash title="Retry wipefs"
sudo wipefs -a /dev/nvme1n1
```

---

### 2. bcache Device Not Showing Up in fdisk

**Symptoms:**  
After initializing the backing device, fdisk does not show `/dev/bcache0`.

**Resolution:**

- **Reload the Kernel Module:**

  ```bash title="Reload the Kernel Module"
  sudo modprobe -r bcache && sudo modprobe bcache
  ```

- **Manually Register the Device:**

  Using the UUID obtained from `bcache-super-show`, execute:

  ```bash title="Manually Register the Device"
  echo "<backing_uuid>" | sudo tee /sys/fs/bcache/register
  ```

- **Clean Up Residual State:**

  If you see that `cset.uuid` is all zeros or the device is in an invalid state, run:

  ```bash title="Clean Up Residual State"
  echo "<cset_uuid>" | sudo tee /sys/fs/bcache/pendings_cleanup
  ```

---

### 3. Cache Device Unexpectedly Detaches or Fails

**Symptoms:**  
During service operation, the cache device disconnects unexpectedly, causing the bcache device to stall or become unresponsive.

**Recommendations:**

- **Test in Advance:**  
  Before deploying in production, test the cache removal procedure on a VM or test machine.

- **Graceful Detach:**  
  Use the detach command to safely remove the cache:

  ```bash title="Detach the Cache Device"
  echo "<cache_set_uuid>" | sudo tee /sys/block/bcache0/bcache/detach
  ```

- **Monitor Dirty Data:**  
  Regularly check the `dirty_data` status to avoid a large buildup of unsynced data in the event of cache failure.

---

### 4. Data Risks in Writeback Mode

**Explanation:**  
Using writeback mode can greatly improve performance; however, if the cache device loses power or fails, any dirty data not yet written to the backing device may be lost.

**Recommendations:**

- Ensure that the cache device (typically an SSD) and power system are reliable.
- For critical systems, consider using an uninterruptible power supply (UPS) or additional data redundancy solutions.
- Regularly monitor and flush data to the backing device.

---

## Conclusion

This document has detailed the process of configuring bcache from scratch—building a storage solution that combines a large capacity backing device with a high-speed cache. It also covers performance tuning, safe cache removal, device migration, and common troubleshooting techniques. Use this manual as a reference to:

- **Deploy Safely:** Test thoroughly and ensure proper data synchronization and backups before making any changes.
- **Tune Precisely:** Adjust cache modes, sequential I/O thresholds, and other parameters according to your workload.
- **Monitor Actively:** Use sysfs and system tools to keep track of device status in real time.
- **Maintain Safely:** Follow the step-by-step troubleshooting procedures to avoid data loss due to improper operations.

May you fully leverage your hardware’s potential while ensuring high performance and stability in your production environment!
