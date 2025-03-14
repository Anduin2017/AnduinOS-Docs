# Gnome Boxes

!!! tip "AnduinOS Verified App - Open Source"

    Gnome Boxes is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Gnome Boxes is a simple application that allows you to create and manage virtual machines. It is a front-end for QEMU and KVM, and it is part of the GNOME project.

To install Gnome Boxes on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install gnome-boxes libvirt-daemon qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils
sudo adduser $USER libvirt
sudo adduser $USER kvm
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
```

You **NEED** to reboot to apply the changes. Or you may see error message: `Permission denied`.
