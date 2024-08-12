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
