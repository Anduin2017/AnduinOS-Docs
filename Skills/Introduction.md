# Getting Started with AnduinOS

AnduinOS is based on Linux. Linux is an operating system. It is open-source and free. It is also very powerful and flexible. You can use Linux for many purposes. However, that requires you to learn how to use it. This guide will help you to get started with Linux.

## Basic Concepts

To effectively use Linux, it's essential to understand some fundamental concepts:

- **Kernel**: The core of the operating system, managing hardware resources and enabling communication between hardware and software.
- **Processes**: Instances of running programs, each with its own memory space and execution context.
- **Files**: The basic units of storage in Linux, organized in a hierarchical directory structure.
- **udev**: The device manager for the Linux kernel, responsible for managing device nodes in the `/dev` directory.
- **Users**: Individuals or entities that interact with the system, each with specific permissions and access levels.
- **Groups**: Collections of users with shared permissions, simplifying access control and management.
- **Permissions**: Rules that define who can access, modify, or execute files and directories.
- **Environment Variables**: Dynamic values that affect the behavior of processes and programs.
- **Shell**: The command-line interface for interacting with the system, executing commands and scripts.
- **Package Managers**: Tools for installing, updating, and managing software packages on the system.
- **Systemd**: A system and service manager for Linux, responsible for managing system processes and services.
- **Networking**: The configuration and management of network interfaces, enabling communication between systems.

## Everything is a File

One of the most powerful and unifying concepts in Linux is that **everything is a file**. This philosophy simplifies the interaction with various system components by treating them uniformly. Here are some examples to illustrate this concept:

- **Regular Files**: Text documents, images, and executables stored in the filesystem.
  
  ```bash
  ls -l /home/user/Documents
  ```

- **Devices**: Hardware components like hard drives, USB devices, and network interfaces are represented as device files in `/dev`.
  
  ```bash
  ls -l /dev/sda
  ```

  You can format and mount a disk using the following commands:

  ```bash
    mkfs.ext4 /dev/sdb1
    mount /dev/sdb1 /mnt/data
  ```

  In the meantime, a single file can also be treated as a disk and it's totally equivalent to a real disk. You can create a file and mount it as a disk:

  ```bash
  dd if=/dev/zero of=disk.img bs=1M count=1
  mkfs.ext4 disk.img
  mount disk.img /mnt/data2
  ```

- **Pipes and Sockets**: Inter-process communication mechanisms are treated as files, allowing processes to read from and write to them.
  
  ```bash
  mkfifo mypipe
  ```

- **System Information**: Virtual files in `/proc` and `/sys` provide real-time system and kernel information.
  
  ```bash
  cat /proc/cpuinfo
  cat /sys/class/net/eth0/address
  ```

## Further Exploration

AnduinOS incorporates a wide array of technologies that enhance its functionality and versatility:

- [**Containers**](./Sandboxing/Using-Docker-As-Container.md): Lightweight, portable units for deploying applications consistently across environments.
- [**KVM (Kernel-based Virtual Machine)**](./Developing/Build-Your-Own-Kernel.md): A virtualization solution integrated into the Linux kernel, enabling the creation of virtual machines.
- [**Wine**](./Sandboxing/Run-Windows-Apps.md): A compatibility layer that allows running Windows applications on Linux.
- [**Package Management**](./System-Management/Use-APT-to-manage-packages.md): Tools for installing, updating, and managing software packages efficiently.
- [**Terminal**](./System-Management/Terminal-Mode.md): A powerful interface for interacting with the system through commands.

To maintain and optimize your AnduinOS system, it's crucial to understand various system management techniques:

- [**Change the Distro Name**](./System-Management/Change-The-Distro-Name.md): Customize the distribution identifier to suit your preferences or organizational standards.
- [**Check File Format**](./System-Management/Check-File-Format.md): Verify and manage file formats to ensure compatibility and integrity.
- [**Check System Layout**](./System-Management/Check-System-Layout.md): Analyze the directory structure and system configuration for optimal performance.
- [**Debug Storage Consumption**](./System-Management/Debug-Storage-Consumption.md): Identify and resolve storage issues to maintain system efficiency.
- [**Make a RAM Disk**](./File-System-Management/Make-A-RAM-Disk.md): Create temporary storage in RAM for faster data access and improved performance.
- [**Mounting Remote Folders**](./File-System-Management/Mounting-Remote-Folder.md): Access and integrate remote directories seamlessly into your local filesystem.
- [**Remove Duplicate APT Sources**](./System-Management/Remove-Duplicate-Apt-Source.md): Clean up package sources to prevent conflicts and streamline updates.
- [**Update Kernel Parameters**](./System-Management/Update-Kernel-Parameters.md): Modify kernel settings to fine-tune system behavior and performance.

## Building Your Own Kernel

Linux's open-source nature invites users to contribute and develop their own solutions.

??? tip "Don't be afraid, building your kernel is easy!"

    Usually, stable kernels are easy to build. You can build your own kernel in 5 simple steps.

In some cases, for example:

* When the current Kernel doesn't support your hardware. (e.g. Wi-Fi, Bluetooth, sound, etc.)
* When you need to add a new feature to the Kernel.
* When you need to remove some Kernel features to reduce the Kernel size.
* When you want to have better performance by optimizing the Kernel for your hardware.
* When you want to learn how the Kernel works.

You may need to build your own Kernel.

You can follow the [guide](./Developing/Build-Your-Own-Kernel.md) to build your own Kernel.

## Enjoy AnduinOS

AnduinOS is a powerful and versatile operating system that can be tailored to suit your specific needs. By exploring its features and capabilities, you can unlock its full potential and leverage its flexibility to enhance your computing experience. Whether you're a seasoned Linux user or new to the platform, AnduinOS offers a rich ecosystem of tools and resources to support your journey and empower you to achieve your goals.
