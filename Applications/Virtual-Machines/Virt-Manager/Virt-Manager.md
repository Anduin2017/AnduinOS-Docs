# Virt Manager

Virt Manager is a graphical tool for managing virtual machines. It is based on libvirt and supports KVM, QEMU, Xen, and LXC. It is written in Python and uses GTK+ for the graphical user interface.

To install Virt Manager on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install virt-manager
```

That's it. If you want to allow current user to connect to the libvirt daemon, you can run:

```bash
sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu
```
