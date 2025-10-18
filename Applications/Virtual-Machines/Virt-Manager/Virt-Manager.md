# Virt Manager

!!! tip "AnduinOS Verified App - Open Source"

    Virt Manager is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Virt Manager is a graphical tool for managing virtual machines. It is based on libvirt and supports KVM, QEMU, Xen, and LXC. It is written in Python and uses GTK+ for the graphical user interface.

## Flatpak install (Recommended)

You can install Virt Manager via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub org.virt_manager.virt-manager
```

## System install

To install Virt Manager on AnduinOS, you can run:

```bash title="Install Virt Manager"
sudo apt update
sudo apt install virt-manager
```

That's it. If you want to allow current user to connect to the libvirt daemon, you can run:

```bash title="Allow running Virt Manager without sudo"
sudo adduser $USER libvirt
sudo adduser $USER kvm
```

You may also want to isntall `virt-viewer` to view the virtual machine console:

```bash title="Install Virt Viewer"
sudo apt install virt-viewer
#cat << EOF > /usr/share/applications/virt-viewer.desktop
echo "
[Desktop Entry]
Name=Virt Viewer
Comment=Connect to virtual machines
Exec=virt-viewer
Icon=virt-viewer
Terminal=false
Type=Application
Categories=System;" | sudo tee /usr/share/applications/virt-viewer.desktop
```

To start the service, you can run:

```bash title="Start the libvirt service"
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
```

Now you can start Virt Manager by running `virt-manager` in the terminal or searching for it in the application menu.

To virtualize Windows on AnduinOS, you can follow the guide [here](../../../Virtualization/Windows.md).
