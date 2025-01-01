# Gnome Boxes

!!! tip "AnduinOS Verified App - Open Source"

    Gnome Boxes is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Gnome Boxes is a simple application that allows you to create and manage virtual machines. It is a front-end for QEMU and KVM, and it is part of the GNOME project.

To install Gnome Boxes on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install gnome-boxes libvirt-daemon
sudo adduser $USER libvirt
sudo adduser $USER kvm
sudo systemctl enable libvirtd
```
