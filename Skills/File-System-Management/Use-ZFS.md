# What is ZFS

ZFS is a modern file system with many features. Some of the important features include:

1. Copy-on-write: When modifying a file, ZFS first copies the data being modified and then performs the modification. This ensures data integrity.

2. Redirect-on-write: When writing new data, ZFS writes the new data to a new location instead of overwriting the existing data. This protects the integrity of the original data and improves write efficiency.

3. Deduplication: When multiple files have the same data blocks, ZFS only keeps one copy of the data block on the storage device, saving storage space.

4. Snapshots: ZFS can take snapshots of the file system at a specific point in time, recording the state of the file system. This allows for easy restoration to a previous state and can also be used for data backup and recovery.

5. Compression: ZFS supports on-the-fly compression of data, which can save storage space and improve performance by reducing the amount of data that needs to be read from or written to the storage device.

6. Caching: ZFS has a built-in cache mechanism called the Adaptive Replacement Cache (ARC) that can improve read performance by keeping frequently accessed data in memory. Additionally, ZFS also supports the use of separate cache devices such as solid-state drives (SSDs) to further improve performance.

7. RAID: ZFS supports multiple RAID levels, including RAID 0, RAID 1, RAID 5, RAID 6, and RAID 10. These RAID levels can be used to improve performance and/or provide data redundancy.

8. Storage pools: ZFS uses storage pools to manage storage devices. A storage pool can consist of one or more storage devices, and the storage capacity of the pool is shared between all devices in the pool. This allows for easy expansion of storage capacity by adding more devices to the pool.

9. Data integrity: ZFS uses checksums to ensure data integrity. When reading data from a storage device, ZFS verifies the checksum of the data to ensure that it has not been corrupted. If the checksum does not match, ZFS will attempt to repair the data by reading it from another device in the pool.

10. Data scrubbing: ZFS can periodically scan the storage devices in a pool to detect and repair data corruption. This helps to ensure that data is not corrupted over time.

These features make ZFS a powerful and reliable file system suitable for large-scale storage and data management scenarios.

## Common knowledge

### Pool

In the world of ZFS, everything is based on storage pools. First, you need to create a storage pool for one or more hard drives. The storage pool manages the disks and provides storage space. The capacity is not shared between multiple storage pools.

**Forget about RAID!** Even you may have a RAID controller, ZFS still expect that you expose all physical disks to a pool!

### Set

On top of the storage pools, we can create multiple datasets. Datasets do not require allocated space, which means each dataset can utilize the entire storage capacity of the pool. A dataset must belong to one and only one storage pool.

After creating a dataset, it is mapped as a directory. This allows you to store and organize files and subdirectories within the dataset. For example, if you create a dataset called "photos", you can map it to a directory like `/mnt/pool/photos`. You can then create subdirectories within this directory to organize your photos. This makes data organization and management more flexible and convenient.

## Commands

### Installation

To install basic utilities, run:

```bash title="Install ZFS utilities"
sudo apt install zfsutils-linux
```

Use some basic tools like `lsblk` and `fdisk` to locate your disk.

### Getting context

List sets:

```bash title="List ZFS sets"
# zfs list
```

List pools:

```bash title="List ZFS pools"
# zpool list
NAME      SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
my_pool  47.5G   387K  47.5G        -         -     0%     0%  1.00x    ONLINE  -
# zpool status
  pool: my_pool
 state: ONLINE
config:

        NAME        STATE     READ WRITE CKSUM
        my_pool     ONLINE       0     0     0
          raidz2-0  ONLINE       0     0     0
            sdb     ONLINE       0     0     0
            sdc     ONLINE       0     0     0
            sdd     ONLINE       0     0     0

errors: No known data errors
```

Also if you want to check the io status, use `zpool iostat`:

```bash title="Check ZFS IO status"
# zpool iostat -v
```

### Managing Pools

* Use one disk to create one pool
* Use multiple disks to create one pool
* Use one disk to create multiple pools

You can **create** a new pool with command (Use one disk):

```bash title="Create a ZFS pool with one disk"
# zpool create my_pool /dev/sda # <--- /dev/sda is your physical disk!
```

To create multiple pools with one disk(NOT suggested):

```bash title="Create multiple ZFS pools with one disk"
# zpool create my_pool /dev/sda1 # <--- /dev/sda1 is your partition. This is NOT suggested because the capacity was not shared between pools!
```

Of course, you can use multiple devices to create one pool:

```bash title="Create a ZFS pool with multiple disks"
# zpool create my_pool raidz  /dev/sdb /dev/sdc # At least 2 disks
# zpool create my_pool raidz2 /dev/sdb /dev/sdc # At least 3 disks
# zpool create my_pool raidz3 /dev/sdb /dev/sdc # At least 4 disks
```

That also creates a ZFS level Raid called Raid-Z.

You may need a calculator for planning ZFS.

[RaidZ calculator](https://wintelguy.com/zfs-calc.pl)

If you bought new disks and want to add the new disk to your existing pool, that's also possible!

```bash title="Add a new disk to an existing ZFS pool"
zpool add my_pool /dev/new
# zfs set quota=new_size my_pool
```

Note that expanding ZFS pools takes some time, depending on the size and number of devices you are adding. During the expansion of the pool, you can still use the data in the pool, but you may experience a performance decrease.

### Managing Sets

To create and mount:

```bash title="Create and mount a ZFS set"
# zfs create pool/set
# zfs set mountpoint=/test pool/set
```

To delete a set:

```bash title="Delete a ZFS set"
# zfs destroy -r pool/set
```

## Features

### Data dedup

You can use the deduplication (dedup) property to remove redundant data from your ZFS file systems. If a file system has the dedup property enabled, duplicate data blocks are removed synchronously. The result is that only unique data is stored, and common components are shared between files.

Pool level

```bash title="Set dedup at pool level"
# zfs get dedup pool
# zfs set dedup=on pool
```

Or set level:

```bash title="Set dedup at set level"
# zfs get dedup pool/set
# zfs set dedup=on pool/set
```

Use `zpool list` to check the dedup ratio.

You may also want to check the total size may change:

```bash title="Check ZFS total size"
root@lab:/my_pool# df -Th
Filesystem     Type   Size  Used Avail Use% Mounted on
my_pool        zfs     18G  3.0G   15G  18% /my_pool
```

Right here,

```text
(Right here, '=' means equals not assignment)
Available space left = ZFS total storage capacity - Raw used space
Available space left = Logical usable storage capacity - Logical used space
Logical usable storage capacity = Available space left + Logical used space
Logical usable storage capacity = ZFS total storage capacity - Raw used space + Logical used space
```

In the world of ZFS, if you enable data deduplication, you will find that the total space of the dataset from df command is dynamically changing.

* Total raw storage capacity: 48G
* Raid Level: RaidZ2
* ZFS usable storage capacity: 16G
* Logical used space: 3G
* Raw used space: 1G
* Dedup ratio: 3x
  * Dedup ratio = Logical used space / Raw used space
* Logical usable storage capacity: Dynamic calculated: 18G
  * Logical usable storage capacity = ZFS usable storage capacity + (Logical used space - Raw used space)
* Available space left: 15G
  * Available space left = ZFS total storage capacity - Raw used space
  * Available space left = Logical usable storage capacity - Logical used space

### Snapshot

Create snapshot:

```bash title="Create a ZFS snapshot"
# zfs snapshot pool/set@name
```

List snapshots:

```bash title="List ZFS snapshots"
# zfs list -t snapshot
```

Rollback to snapshot:

```bash title="Rollback to a ZFS snapshot"
# zfs rollback pool/set@name
```

Rollback is **Dangerous**! It may delete the status between current and the snapshot! Use clone instead:

```bash title="Clone a ZFS snapshot"
# zfs clone pool/set@name pool/set2
```

That will clone the snapshot as a dataset.

Delete snapshot:

```bash title="Delete a ZFS snapshot"
# zfs destroy pool/set@name
```

### Compression

By default, compression is disabled:

```bash title="Check ZFS compression status"
# zfs get compression my_pool
```

To enable it:

```bash title="Enable ZFS compression"
# zfs set compression=lz4 my_pool
```

`lz4` is a very fast compression algorithm that has very little CPU overhead, so it's a good choice if you want to maximize performance. It's also the default compression algorithm used by ZFS on most systems.

You can also use `gzip` or `zle`. Compare with lz4, gzip is slower but has a higher compression ratio, while zle is faster but has a lower compression ratio.

```bash title="Set ZFS compression algorithm"
# zfs set compression=gzip my_pool
# zfs set compression=zle my_pool
```

> The impact of enabling lz4 on performance needs to be analyzed on a case-by-case basis. Enabling lz4 is like making some disk reading tasks simpler: just read the compressed data and have the CPU decompress it. The problem is that large-scale decompression may consume CPU performance, although it takes up very little. Therefore, lz4 can significantly improve performance in situations where the CPU is strong and there is a lot of redundant disk data. However, lz4 may not necessarily improve performance when the CPU is weak and almost all disk data is already compressed.

To query current compress ratio:

```bash title="Check ZFS compress ratio"
# zfs get compressratio my_pool
```

### Caching

ZFS has a built-in caching mechanism called Adaptive Replacement Cache (ARC) to improve read performance. ARC is a dynamic cache that automatically adjusts its size based on the system's memory usage. It stores frequently accessed data in memory so that the system can access it quickly.

ZFS also supports the use of separate caching devices, such as solid-state drives (SSDs), to further improve performance. These caching devices are called ZFS Intent Log (ZIL) and ZFS Cache (L2ARC). ZIL is used to improve the performance of synchronous writes, while L2ARC is used to improve the performance of read operations.

Using separate caching devices can significantly improve performance in situations where system memory is limited or the workload is particularly read-intensive. However, using caching devices may also increase the cost of the storage system, so the benefits and costs need to be considered before implementing them.

For exmaple, to use two Samsung NVME solid-state drives as ZFS cache devices, which can significantly improve read and write performance:

Firstly, you need to allocate these two NVME solid-state drives to ZFS Intent Log (ZIL) and Level 2 Adaptive Replacement Cache (L2ARC) respectively.

To allocate an NVME solid-state drive to ZIL, use the following command:

```bash title="Allocate NVME SSD to ZIL"
# zpool add my_pool log nvme0n1
```

Here, `my_pool` is your ZFS pool name, and `nvme0n1` is your NVME solid-state drive device name.

To allocate an NVME solid-state drive to L2ARC, use the following command:

```bash title="Allocate NVME SSD to L2ARC"
# zpool add my_pool cache nvme1n1
```

Here, `my_pool` is your ZFS pool name, and `nvme1n1` is your NVME solid-state drive device name.

After allocating the NVME solid-state drive to ZIL and L2ARC, you can use the following command to view the status of the ZFS pool:

```bash title="Check ZFS pool status"
# zpool status my_pool
```

Usually, for a 16GB pool, the suggested ZIL size is 4GB, and the suggested L2ARC size is 4GB.

To check details:

```bash title="Check ZFS cache details"
# cat /proc/spl/kstat/zfs/arcstats
```

### RAID

ZFS supports multiple RAID levels, including RAID 0, RAID 1, RAID 5(Z), RAID 6(Z2), and RAID 10. These RAID levels can be used to improve performance and/or provide data redundancy.

To create a RAID 0 pool, use the following command:

```bash title="Create a ZFS RAID 0 pool"
# zpool create my_pool /dev/sda /dev/sdb
```

Here, `my_pool` is your ZFS pool name, and `/dev/sda` and `/dev/sdb` are your hard drive device names.

To create a RAID 1 pool, use the following command:

```bash title="Create a ZFS RAID 1 pool"
# zpool create my_pool mirror /dev/sda /dev/sdb
```

Here, `my_pool` is your ZFS pool name, and `/dev/sda` and `/dev/sdb` are your hard drive device names.

To create a RAID 5 pool, use the following command:

```bash title="Create a ZFS RAID 5 pool"
# zpool create my_pool raidz /dev/sda /dev/sdb /dev/sdc
```

Here, `my_pool` is your ZFS pool name, and `/dev/sda`, `/dev/sdb`, and `/dev/sdc` are your hard drive device names.

To create a RAID 6 pool, use the following command:

```bash title="Create a ZFS RAID 6 pool"
# zpool create my_pool raidz2 /dev/sda /dev/sdb /dev/sdc /dev/sdd
```

Here, `my_pool` is your ZFS pool name, and `/dev/sda`, `/dev/sdb`, `/dev/sdc`, and `/dev/sdd` are your hard drive device names.

### Scrubbing

ZFS can periodically scan the storage devices in a pool to detect and repair data corruption. This helps to ensure that data is not corrupted over time.

To start a scrub, use the following command:

```bash title="Start a ZFS scrub"
# zpool scrub my_pool
```

Here, `my_pool` is your ZFS pool name.

To view the status of a scrub, use the following command:

```bash title="Check ZFS scrub status"
# zpool status my_pool
```

To stop a scrub, use the following command:

```bash title="Stop a ZFS scrub"
# zpool scrub -s my_pool
```

### Integrity

ZFS uses checksums to ensure data integrity. When reading data from a storage device, ZFS verifies the checksum of the data to ensure that it has not been corrupted. If the checksum does not match, ZFS will attempt to repair the data by reading it from another device in the pool.

To enable checksums, use the following command: (Enabled by default)

```bash title="Enable checksums"
# zfs set checksum=on my_pool
```

## My configuration example

Here is my configuration example:

```bash title="My ZFS configuration example"
# Create a pool with 12 disks
sudo zpool create -o ashift=12 pool raidz2 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120 \
    /dev/disk/by-id/ata-TOSHIBA_HDWD120

# Set some properties
sudo zfs set compression=lz4 recordsize=1M xattr=sa dnodesize=auto pool

# Create a dataset
sudo zfs create -o mountpoint=/mnt/pool pool/data

# Add cache and log
sudo zpool add pool cache nvme0n1
sudo zpool add pool log   nvme1n1

# Disable sync and atime for performance
sudo zfs set sync=disabled pool
sudo zfs set atime=off pool
```
