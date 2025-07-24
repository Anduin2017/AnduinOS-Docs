# Boot physical disk

In some cases, you may have a physical disk with Windows installed that you want to boot from in a virtual machine. This can be useful for testing or running legacy applications.

## Before starting: Understand the formats

Before proceeding, it's important to understand the different disk image formats and how they relate to physical disks:

* RAW format
* QCOW2 format
* VMDK format

RAW is a raw disk image format that represents the exact contents of a disk. QCOW2 is a more advanced format that supports features like snapshots and compression. VMDK is a format used by VMware products.

When you have a physical disk, you can treat the entire disk, for example `/dev/sdX`, as a raw disk image. You can also create virtual disk images in QCOW2 or VMDK formats from the physical disk.

QCOW2 and VMDK formats are often used for virtual machines, while RAW is a simple representation of the disk contents.

QCOW2 supports features like snapshots and compression, making it more efficient for storage.

Similarly, VMDK is used by VMware products and can be converted to and from other formats.

## Copy\Backup\Restore physical disk with virtual disk

To copy the physical disk to a virtual disk, you can use the `dd` command. This command will create an image of the physical disk and save it as a virtual disk file.

```bash title="Copy physical disk to virtual disk"
sudo dd if=/dev/sdX of=/path/to/virtual-disk.img bs=4M status=progress
```

Replace `/dev/sdX` with the actual device name of your physical disk and `/path/to/virtual-disk.img` with the desired path for the virtual disk image.

And of course, you can copy the virtual disk back to the physical disk if needed:

```bash title="Copy virtual disk back to physical disk"
sudo dd if=/path/to/virtual-disk.img of=/dev/sdX bs=4M status=progress
```

This is useful if you want to back up the virtual disk or restore it to the physical disk later.

## Convert a disk to qemu-img format

To convert a disk image to the QEMU image format, you can use the `qemu-img` command. This is particularly useful if you need to use the disk with QEMU or KVM.

```bash title="Install qemu-utils"
sudo apt update
sudo apt install qemu-utils
```

Then, you can convert the disk image:

```bash title="Convert raw disk to qcow2 format"
qemu-img convert -f raw -O qcow2 /path/to/virtual-disk.img /path/to/virtual-disk.qcow2
```

Or you can directly create a new qcow2 image from the physical disk:

```bash title="Create qcow2 image from physical disk"
qemu-img convert -f raw -O qcow2 /dev/sdX /path/to/virtual-disk.qcow2
```

## Convert a disk to\from VMDK format

To convert a disk image to or from VMDK format, you can also use the `qemu-img` command. This is useful if you need to work with VMware products.

```bash title="Convert raw disk to VMDK format"
qemu-img convert -f raw -O vmdk /path/to/virtual-disk.img /path/to/virtual-disk.vmdk
```

To convert a VMDK back to a raw disk image, you can use:

```bash title="Convert VMDK to raw disk"
qemu-img convert -f vmdk -O raw /path/to/virtual-disk.vmdk /path/to/virtual-disk.img
```

And you can also convert a qcow2 image to VMDK format:

```bash title="Convert qcow2 to VMDK format"
qemu-img convert -f qcow2 -O vmdk /path/to/virtual-disk.qcow2 /path/to/virtual-disk.vmdk
```

To convert a VMDK back to qcow2 format, you can use:

```bash title="Convert VMDK to qcow2 format"
qemu-img convert -f vmdk -O qcow2 /path/to/virtual-disk.vmdk /path/to/virtual-disk.qcow2
```

## Booting the virtual machine

It is suggested to use the `gnome-boxes` application to boot the virtual machine with the created disk image. This application provides a user-friendly interface for managing virtual machines.

To boot the virtual machine, follow these steps:

1. Convert the physical disk to a virtual disk image to qcow2 format using the `qemu-img` command as shown above.
2. Open `gnome-boxes`.
3. Click on "New" to create a new virtual machine.
4. Select "Use a disk image" and choose the qcow2 image you created.
5. Follow the prompts to configure the virtual machine settings.
6. Once the virtual machine is created, you can start it by clicking on the "Start" button.

If the virtual machine does not boot, you can enable the UEFI firmware in the virtual machine settings. This is often necessary for Windows installations.

```xml title="Enable UEFI firmware in gnome-boxes"
<os firmware="efi">
    ...
</os>
```
