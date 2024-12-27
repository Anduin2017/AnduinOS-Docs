# Check System Layout

After setting up a new Linux machine, at least you need to understand the layout. Including the CPU, memory, disk, and network. You can check the server layout by running:

```bash title="Check the machine's basic information"
Green="\033[32m"
Blue="\033[36m"
Font="\033[0m"
OK="${Green}[  OK  ]${Font}"
function print() {
  echo -e "${OK} ${Blue} $1 ${Font}"
}

print "OS information"
sudo lsb_release -a
print "OS install date"
stat -c %w /
print "Kernel version"
uname -r
print "Secure Boot status"
sudo mokutil --sb-state
print "Root file system"
sudo df -Th /
print "Boot mode"
if [ -d /sys/firmware/efi ]; then echo "Boot mode: UEFI"; else echo "Boot mode: Legacy"; fi
print "CPU information"
sudo lscpu
print "PCIE information"
sudo lspci
print "USB information"
sudo lsusb
print "Disk layout"
sudo lsblk
print "All disks information"
sudo fdisk -l
print "Disk usage"
sudo df -Th
print "Memory information"
sudo free -h
print "Network information"
sudo ip link show
print "Firewall status"
sudo ufw status
print "Network location"
curl https://ipinfo.io
```

## Find OS Installation Date

To find the OS install time on AnduinOS, you can use the `stat` command:

```bash title="Find OS install time"
stat /
```

And you can filter the `Birth` field to get the OS install time:

```bash title="Find OS install time"
stat / | grep Birth
```

Or even simpler, you can run:

```bash title="Find OS install time"
stat -c %w /
```

That's it!

## Check Secure Boot Status

To check the Secure Boot status on AnduinOS, you can use the `mokutil` command:

```bash title="Check Secure Boot status"
sudo mokutil --sb-state
```

You can also check the signature database status:

```bash title="Check Secure Boot status"
sudo mkutil --list-enrolled
```

## Check Root File System

To check the root file system on AnduinOS, you can use the `df` command:

```bash title="Check root file system"
sudo df -Th /
```

## Check Boot Mode

To check the boot mode on AnduinOS, you can use the following command:

```bash title="Check boot mode"
if [ -d /sys/firmware/efi ]; then echo "Boot mode: UEFI"; else echo "Boot mode: Legacy"; fi
```

## Check CPU Information

To check the CPU information on AnduinOS, you can use the `lscpu` command:

```bash title="Check CPU information"
sudo lscpu
```

## Check PCIE devices

To check the PCIE devices on AnduinOS, you can use the `lspci` command:

```bash title="Check PCIE information"
sudo lspci
```

## Check USB devices

To check the USB devices on AnduinOS, you can use the `lsusb` command:

```bash title="Check USB information"
sudo lsusb
```

## Check Disk Layout

To check the disk layout on AnduinOS, you can use the `lsblk` command:

```bash title="Check disk layout"
sudo lsblk
```

Which will output all mounted disks and partitions.

To also check all available disks, you can use the `fdisk` command:

```bash title="Check all disks information"
sudo fdisk -l
```

To know the file system and disk usage, you can use the `df` command:

```bash title="Check disk usage"
sudo df -Th
```

You can also use `df` to check a specific folder:

```bash title="Check disk usage"
sudo df -Th /path/to/folder
```

## Check Memory Information

To check the memory information on AnduinOS, you can use the `free` command:

```bash title="Check memory information"
sudo free -h
```

To check memory usage in real-time, you can use the `watch` command:

```bash title="Check memory usage in real-time"
watch -n 1 free -h
```

To check all processes and their memory usage, you can use the `top` command:

```bash title="Check all processes, sort by memory usage"
top -o %MEM
```

## Check Network Information

By default, AnduinOS use NetworkManager to manage network connections.

To check the NetworkManager status, you can use the `systemctl` command:

```bash title="Check NetworkManager status"
sudo systemctl status NetworkManager
```

To edit the NetworkManager configuration, you can use the `nmcli` command:

```bash title="Edit NetworkManager configuration"
sudo nmcli connection edit connection_name
```

Or even easier, simply use `gnome-control-center`:

To check the network information on AnduinOS, you can use the `ip` command:

```bash title="Check network information"
sudo ip link show
```

## Check Firewall Status

To check the firewall status on AnduinOS, you can use the `ufw` command:

```bash title="Check firewall status"
sudo ufw status
```

To allow a specific port, you can use the `ufw` command:

```bash title="Allow a specific port"
sudo ufw allow 80
```

To view all rules, you can use the `ufw` command:

```bash title="View all rules"
sudo ufw status numbered
```

To remove a specific rule, you can use the `ufw` command:

```bash title="Remove a specific rule"
sudo ufw delete 1
```

## Check Network Location

To check the network location on AnduinOS, you can use the `ipinfo` command:

```bash title="Check network location"
curl https://ipinfo.io
```

## Check kernel version

To check the kernel version on AnduinOS, you can use the `uname` command:

```bash title="Check kernel version"
uname -r
```

## Check kernel log

To check the kernel log on AnduinOS, you can use the `dmesg` command:

```bash title="Check kernel log"
sudo dmesg
```
