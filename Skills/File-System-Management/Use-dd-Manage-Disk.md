# Use dd to manage disks

## Everything is a File

In Linux, **everything is treated as a file** — not just `.txt` or `.jpg`.

Examples:

* Hard disk → `/dev/sda`
* Partition → `/dev/sda1`
* CD-ROM → `/dev/sr0`
* Even keyboard or mouse → `/dev/input/*`

If it can be read or written, it behaves like a file.

And filesystem helps transform the disk from raw bytes under `/dev/sda` into a structured directory tree like `/home/user/documents`.

## What is `dd`?

`dd` is a low-level copy tool.
It **copies data byte-by-byte** from one file (or device) to another.

```bash
dd if=input_file of=output_file
```

* `if` = input file/device
* `of` = output file/device

`dd` doesn't care if it's copying a text file or a disk. It's raw.

## Copying a Disk = Copying a File

Since disks are just files in `/dev/`,
you can back up a disk like this:

```bash
dd if=/dev/sda of=disk.img bs=4M status=progress
```

This reads `/dev/sda` (the whole disk), and writes it to a regular file.

You can later restore it:

```bash
dd if=disk.img of=/dev/sda bs=4M status=progress
```

!!! warning "Data loss risk"

    **`dd` is powerful but dangerous**. A small mistake can wipe out your data. The command above will wipe everything on `/dev/sda` and replace it with the contents of `disk.img`. Always double-check your commands!

## Special Files: `/dev/zero`, `/dev/null`, `/dev/random`

Linux has “virtual files” that behave like endless data sources or sinks:

* `/dev/zero` → infinite zero bytes (0x00)
* `/dev/null` → a black hole; discards anything written
* `/dev/random` → random bytes (from entropy pool)

Examples:

```bash
dd if=/dev/zero of=zero.bin bs=1M count=1
```

Creates a 1MB file filled with zeros.

```bash
dd if=/dev/random of=random.bin bs=512 count=4
```

Creates 2KB of random binary data.

## Files Can Be Virtual Disks

You can **treat any file like a disk** using `dd` and loop mounts.

1. Create a 4GB file:

```bash
dd if=/dev/zero of=disk.img bs=1M count=4096
```

2. Format it as ext4:

```bash
mkfs.ext4 disk.img
```

3. Mount it:

```bash
sudo mount -o loop disk.img /mnt
```

Now `/mnt` behaves like a real mounted disk.

To unmount:

```bash
sudo umount /mnt
```

## Use Cases: Real-World `dd` Examples

### 1. Full Disk Backup

```bash
dd if=/dev/sda of=backup.img bs=4M status=progress
```

Saves your entire disk into one image file.

### 2. Full Disk Restore

```bash
dd if=backup.img of=/dev/sda bs=4M status=progress
```

Restores the image to the original disk (destructive!).

### 3. Disk-to-Disk Cloning

```bash
dd if=/dev/sda of=/dev/sdb bs=4M status=progress
```

Copies `/dev/sda` directly onto `/dev/sdb`. Useful for migration or duplicaion.

### 4. Wipe a Disk

```bash
dd if=/dev/zero of=/dev/sda bs=1M status=progress
```

Wipes `/dev/sda` by writing zeros, effectively erasing all data.

However, `random` data is more secure:

```bash
dd if=/dev/urandom of=/dev/sda bs=1M status=progress
```

### 5. Test file system read/write speed

To test the read/write speed of a folder, you can use `dd` to write a large file and measure the time taken:

Test write speed:

```bash
dd if=/dev/zero of=testfile bs=1G count=1 oflag=direct
```

Test read speed:

```bash
dd if=testfile of=/dev/null bs=1G count=1 iflag=direct
```

### 6. Test raw disk read/write speed

To test the raw disk read/write speed, you can use `dd` directly on the device:

!!! warning "Caution: This will overwrite data on the disk!"

    Make sure you know what you're doing. Running these commands on device results in data loss.

Test write speed:

```bash
dd if=/dev/zero of=/dev/sda bs=1G count=1 oflag=direct
```

Test read speed:

```bash
dd if=/dev/sda of=/dev/null bs=1G count=1 iflag=direct
```

## ⚠️ Caution and Best Practices

* Always double-check device names with `lsblk` or `fdisk -l`
* Never mix up `if=` and `of=` — one typo can wipe a disk.
* Add `status=progress` to see live copy stats.
* Consider `conv=fsync` to flush writes to disk after copy.
