# Setup a new Linux server after buying from an external provider

If you have bought a server from an external provider, usually it's not following the Linux authentication best practices. You need to set it up properly before hosting services on it.

## Preparation

### Check the server layout

After buying a new server, at least you need to understand the server layout. Including the CPU, memory, disk, and network. You can check the server layout by running:

```bash title="Check the server layout"
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
print "Memory speed"
sudo dmidecode --type memory | grep -i "Memory Speed"
print "Network information"
sudo ip link show
print "Firewall status"
sudo ufw status
print "Network location"
curl https://ipinfo.io
```

## Authentication

### Connect to the server

After buying a server, it will provide you:

* IP address
* Username (Usually `root`)
* Password

So you can connect to the server using SSH. For example:

```bash title="Connect to the server (Run on your local machine)"
ssh default-user-name@your-server-ip
```

------

### Change hostname

By default, the hostname of the server is usually not set properly. You can change it by running:

```bash title="Change hostname"
sudo hostnamectl set-hostname your-hostname
sudo reboot
```

!!! warning "Only limited characters are allowed"

    The hostname can only contain letters, numbers, and hyphens. It cannot start or end with a hyphen. It cannot contain spaces or special characters like underscores.

    For example, `your-hostname` is a valid hostname, but `your-hostname-` is not.
    For example, `your-hostname` is a valid hostname, but `your_hostname` is not.

You also need to update `/etc/hosts` to add the new hostname as `127.0.0.1`:

```bash title="Update /etc/hosts"
sudo vim /etc/hosts
```

Inside the /etc/hosts file, add the new hostname as `127.0.0.1`, like this:

```bash title="Update /etc/hosts"
127.0.0.1   localhost
127.0.1.1   your-hostname
```

Make sure to replace your-hostname with the actual hostname you set using the hostnamectl command. Save and close the file.

!!! note "Use the vim editor"

    To start editing the file in vim, you can press `i` to enter insert mode. You can use the arrow keys to navigate and edit the file.

    To save and close the file in vim, you can press `ESC` and then type `:wq` and press `Enter`.

------

### Create a new user

It's not recommended to use the root user for daily tasks. You should create a new user and give it sudo permission. For example:

```bash title="Create a new user"
sudo adduser your-username
```

Enter the password and other information as prompted.

Then add the user to the sudo group:

```bash title="Add the user to the sudo group"
sudo usermod -aG sudo your-username
```

Now you can test the new user's root permission:

```bash title="Test the new user's root permission"
su - your-username
whoami
sudo ls
```

------

### Copy SSH public key

!!! note "Run on your local machine!"

    The next command should be run on your local machine instead of the server! No matter your local machine is running Windows, macOS, or Linux, you can still run the command below. All those systems support the SSH command.

By default, the server provider will give you a password to connect to the server. It's recommended to use [SSH key](../Skills/Secret-Management/Manage-SSH-Keys.md) instead. You can generate a new SSH key pair on your local machine:

!!! warning "Generate a new SSH key pair"

    Don't overwrite the existing SSH key pair if you already have one!

    The command above will overwrite the existing SSH key pair. You can check if you already have an SSH key pair by running:

    ```bash
    ls ~/.ssh
    ```

```bash title="Generate a new SSH key pair (Run on your local machine)"
ssh-keygen
```

Then copy the public key to the server:

```bash title="Copy SSH public key (Run on your local machine)"
ssh-copy-id your-username@your-server-ip
```

Now you can connect to the server without a password:

```bash title="Connect to the server without password (Run on your local machine)"
ssh your-username@your-server-ip
```

If the server didn't ask for a password, you have successfully set up the SSH key.

------

### Disable root login

It's not recommended to allow root login via SSH. You should disable it by editing the SSH configuration file:

```bash title="Disable root login"
sudo vim /etc/ssh/sshd_config
```

* Change: `PermitRootLogin` to `no` to disable the root user login.
* Change `PasswordAuthentication` to `no` to disable password login. (Make sure you can use SSH key login before disabling password login)
* Change `PubkeyAuthentication` to `yes` to allow ssh key login.

Then restart the SSH service:

```bash
sudo systemctl restart sshd
```

------

### Allow your user to run sudo without password (Optional)

Allowing sudo without password is a security risk, but it can be useful in certain situations.

!!! warning "Security Risk"

    Disabling the password requirement for sudo can be a security risk. This may cause some commands running without sudo to have root permissions and potentially break your system.

However, if you prefer to allow sudo without password, you can follow the steps below.

Open the sudoers file with the visudo command:

```bash title="Allow sudo without password"
sudo mkdir -p /etc/sudoers.d
sudo touch /etc/sudoers.d/$USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USER
```

That's it! You can now run sudo commands without entering your password.

------

### Delete other users

By default, the server provider may create some users for you. You should delete them if you don't need them.

To list all users which can login to the server, you can run:

```bash title="List all users"
cat /etc/passwd | grep -v nologin | grep -v false
```

Usually the users are:

<div class="annotate" markdown>

* root
* sync (1)
* your-username

</div>

1.  The `sync` user is used for synchronizing the system clock. It's safe to keep it.

To delete a user, you can run:

```bash title="Delete other users"
sudo deluser --remove-home other-username
```

It is also suggested to delete the user's home directory:

```bash title="Delete user's home directory"
sudo ls /home
sudo rm -rf /home/other-username
```

------

## Network

### Renew Machine ID

If you have cloned the server, (For some cloud providers, the server is cloned from a template), you need to renew the machine ID to avoid conflicts. You can renew the machine ID by running:

```bash title="Renew Machine ID"
sudo rm /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo systemd-machine-id-setup
sudo cp /etc/machine-id /var/lib/dbus/machine-id
```

------

### Enable firewall

By default, the server provider may not enable the firewall. You should enable it to protect your server.

You can use `ufw` to enable the firewall. Before doing that, make sure you allow the SSH port:

```bash title="Tell ufw to allow your necessary ports"
sudo ufw allow ssh
sudo ufw allow 80 # 80 is an example for your other business ports
```

Then enable the firewall:

```bash title="Enable ufw"
sudo ufw enable
```

------

### Enable CrowdSec to enhance security

CrowdSec is an open-source security tool that can help you block malicious IP connections. You can use it to block hackers, bots, and other malicious connections.

```bash title="Install crowdsec"
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get install crowdsec
```

!!! warning "CrowdSec uses 8080 port"

    CrowdSec uses 8080 port by default. Make sure you don't have any service running on 8080 port.

    You can change this port by editing the `/etc/crowdsec/crowdsec.yaml` file.

CrowdSec is a senario-based security tool. You can list all the scenarios by running:

```bash title="List all CrowdSec scenarios"
sudo cscli scenarios list
```

CrowdSec leverages Bouncer to block bad IPs. handle malicious behavior once it’s detected. To block TCP/UDP connections with blacklisted IPs, install the CrowdSec firewall Bouncer:

```bash title="Install CrowdSec Bouncer"
sudo apt-get install crowdsec-firewall-bouncer-iptables
sudo systemctl start crowdsec-firewall-bouncer
sudo systemctl enable crowdsec-firewall-bouncer
```

You can verify the current rules and decisions by running:

```bash
# Collections are the CVEs that have been detected
sudo cscli collections list
# Senarios are the rules that detect malicious behavior
sudo cscli scenarios list
# Decisions are the IPs that have been blocked
sudo cscli decisions list
# Bouncers are the tools that block the IPs
sudo cscli bouncers list
```

You should regularly update the CrowdSec database to get the latest security rules:

```bash title="Update CrowdSec database"
sudo cscli hub update
sudo cscli hub upgrade
```

You can use CrowdSec’s IP blacklist feature to manually add or regularly update blacklisted IP addresses. To manually add an IP to the blacklist:

```bash
sudo cscli decisions add -i [IP address]
```

Now you have enabled CrowdSec to enhance your server security.

------

### Enable BBR for congestion control

BBR is a congestion control algorithm developed by Google. It can improve network performance. You can enable it by running:

```bash title="Enable BBR"
enable_bbr_force()
{
    echo "BBR not enabled. Enabling BBR..."
    echo 'net.core.default_qdisc=fq' | sudo tee -a /etc/sysctl.conf
    echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    echo "BBR enabled. Reboot to take effect."
}
sudo sysctl net.ipv4.tcp_available_congestion_control | grep -q bbr ||  enable_bbr_force
```

!!! warning "BBR with fq qdisc"

    BBR *must* be used with the fq qdisc ("man tc-fq") with pacing enabled, since pacing is integral to the BBR design and implementation. BBR without pacing would not function properly, and may incur unnecessary high packet loss rates. [source](https://groups.google.com/g/bbr-dev/c/4jL4ropdOV8/m/0-bNH-KEBgAJ?pli=1)

    To enable fq qdisc, you can run:

    ```bash title="Enable fq"
    enable_fq()
    {
        echo "fq not enabled. Enabling fq..."
        echo 'net.core.default_qdisc=fq' | sudo tee /etc/sysctl.conf
        sudo sysctl -p
        judge "Enable fq"
    }
    sysctl net.core.default_qdisc | grep -q fq ||  enable_fq
    print_ok "fq enabled"
    ```

------

### Setup best apt mirror

By default, the server provider may not set the best apt mirror for you. You can set it by following [guidance here](../Install/Select-Best-Apt-Source.md).

------

## Security

### Install Fail2Ban (Optional)

Fail2Ban is a log-parsing tool that can help you block malicious IP connections. It can monitor log files and ban IPs that show malicious signs, such as too many password failures.

You can install Fail2Ban and configure it to protect your SSH service. It will automatically ban IPs that fail to log in too many times.

```bash title="Install Fail2Ban and configure SSH jail"
#!/usr/bin/env bash
set -euo pipefail

echo "[+] Updating package index and installing fail2ban..."
sudo apt update
sudo apt install -y fail2ban

echo "[+] Writing /etc/fail2ban/jail.local..."
sudo tee /etc/fail2ban/jail.local > /dev/null <<'EOF'
[sshd]
enabled  = true
port     = ssh
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 3
findtime = 600
bantime  = 3600
EOF
sleep 1

echo "[+] Restarting fail2ban service..."
sudo systemctl restart fail2ban

echo "=== Fail2Ban global status ==="
# Allow script to continue even if fail2ban-client status fails (e.g., socket not yet ready)
sudo fail2ban-client status || true

echo "=== SSHD jail status ==="
sudo fail2ban-client status sshd || true

echo "Tip: To view the currently banned IP list again, run:"
echo "sudo fail2ban-client status sshd"

echo "Tip: To unban an IP address, run:"
echo "sudo fail2ban-client set sshd unbanip <IP_ADDRESS>"

echo "Tip: To ban an IP address manually, run:"
echo "sudo fail2ban-client set sshd banip <IP_ADDRESS>"

echo "Tip: To view the fail2ban logs, run:"
echo "sudo journalctl -u fail2ban"
```

------

### Run security updates

After setting up the server, you should run security updates to make sure the server is secure:

```bash title="Run system updates"
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

------

### Enable Automatic Security Updates (Optional)

Every day there are new security vulnerabilities discovered in software. To protect your server from these vulnerabilities, you should always keep your server up-to-date with the latest security patches.

However, it can be time-consuming to manually update your server every day. To save time, you can enable automatic security updates on your server.

??? Tip "Should those commands be run automatically?"

    Automatic updates can save time and ensure you get security updates as soon as possible. They keep your packages clean and new, reducing the pain of large, infrequent upgrades. Historically, running `apt upgrade` has been very safe, with few reported issues. Additionally, automatic updates are common in other operating systems like Microsoft Windows.

    However, automatic updates are not recommended for most Linux users due to several reasons:

    - **Investigation**: Auto-updates can mask real problems, making it difficult to reproduce issues and their dependency trees during troubleshooting.
    - **AirGap Stability**: Some systems require extreme stability and cannot tolerate changes, such as flight control systems.
    - **Upgrade Risks**: New versions may introduce bugs or breaking changes, causing business interruptions.
    - **Rebooting Issues**: Updates often require reboots, which can be problematic for systems that have difficulty restarting or need to maintain synchronized caches.

    Automatic updates are advisable only if:

    - The system can tolerate availability degradation.
    - The system is stateless and rebooting won't affect its operation.
    - The system has a perfect backup or snapshot configuration.
    - The system is always connected to the Internet.
    - The system needs the latest functional updates.

    Consider these factors carefully before enabling automatic updates.

If you want to enable automatic updates, you can use the following script to set up unattended upgrades on your system.

```bash title="Setup automatic updates"
echo "
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
sudo apt --purge autoremove -y" | sudo tee /usr/local/bin/update.sh
sudo chmod +x /usr/local/bin/update.sh
(crontab -l ; echo "0 2 * * 0 /usr/local/bin/update.sh") | crontab -
```

------

## Performance

### Install latest kernel

By default, the server provider may not install the latest kernel for you.

!!! warning "Kernel version"

    The kernel version may vary depending on the Ubuntu version. You should check the latest kernel version for your Ubuntu version.

    It is always recommended to use a newer kernel for better performance and security, especially if you are using a server with newer hardware.

To verify the current kernel version, you can run:

```bash title="Check current kernel version"
uname -r
```

You can install the latest kernel by running:

```bash title="Install latest kernel"
sudo apt search linux-generic-hwe-* | awk -F'/' '/linux-generic-hwe-/ {print $1}' | sort | head -n 1 | xargs -r sudo apt install -y
sudo reboot
```

------

### Tune CPU from power-saver to performance

If you are running on a bare-metal server, you can tune the CPU from power-saver to performance to get better performance:

```bash title="Tune CPU to performance"
sudo apt install -y linux-tools-common linux-tools-$(uname -r)
sudo cpupower frequency-info
sudo cpupower frequency-set -g performance
```

------

## System

### Change timezone

By default, the server provider may not set the timezone properly. You should set it correctly. And it's recommended to set it to GMT.

For example, to set the timezone to GMT:

```bash title="Change timezone"
sudo timedatectl set-timezone GMT
```

To set the timezone to your local timezone, you can run:

```bash title="Change timezone to China"
sudo timedatectl set-timezone Asia/Shanghai
```

------

### Remove Snap (Optional)

Snap is a package manager that can be used to install applications. However, I understand that a lot of Ubuntu users don't like Snap. You can remove Snap by running:

```bash title="Remove Snap"
echo "Removing snap..."
sudo systemctl disable --now snapd
sudo apt purge -y snapd
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd ~/snap
cat << EOF | sudo tee -a /etc/apt/preferences.d/no-snap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
sudo chown root:root /etc/apt/preferences.d/no-snap.pref
echo "Snap removed"
```

------

### Benchmark your server (Optional)

After setting up the server, you can benchmark it to see the performance. You can use tools like `iperf3` to test the network speed and `sysbench` to test the CPU performance.

For example, to use `iperf3` to test the network speed:

```bash title="Test network speed"
sudo apt update
sudo apt install -y iperf3
sudo ufw allow 5201
iperf3 -s
```

Then on your local machine, you can run:

```bash title="Test network speed"
iperf3 -c your-server-ip
```

To use `sysbench` to test the CPU performance:

```bash title="Test CPU performance"
sudo apt install -y sysbench
sysbench cpu --threads=$(nproc) run
```

The following is the benchmark result for different CPUs (AMD64 architecture, under Linux):

| CPU                              | Total number of events |
| -------------------------------- | ---------------------- |
| Intel Xeon Platinum 8358P x2     | 182,0000                |
| Intel Core Ultra 9 285           | 150,0000                |
| Intel Core i9 13900KS            | 100,0000                |
| AMD Ryzen 9 6900HS               |  45,0000                |
| Intel Core i9 13900H             |  43,0000                |
| Intel Core i9 10900H             |  40,0000                |
| AMD Ryzen 7 6800HS               |  40,0000                |
| Intel E5 2680 v4                 |  39,8000                |
| AMD Ryzen 7 5800H                |  37,9000                |
| Intel Core i9 10900X             |  23,0000                |
| Intel i7-8700K                   |  13,5000                |
| Intel N100                       |  11,0000                |
| Vultr 2 vCPU                     |   7,0000                |
| Azure B1s                        |   1,8000                |
| 腾讯云轻量应用                    |   1,6000                |

| Average latency (ms) | Rating     |
| --------------- | -----------|
| 0-0.2           | Awesome    |
| 0.2-1           | Good       |
| 1-2             | Normal     |
| 2-5             | Acceptable |
| 5-10            | Bad        |
| 10+             | Terrible   |

To benchmark a single core, you can use `taskset`:

```bash title="Test CPU 0 only"
taskset -c 0 sysbench cpu --threads=1 run
```

------

### Install runtime (Optional)

By default, the server provider may not install the runtime for you. You can install the runtime.

* [Node.js](../Applications/Development/Node/Node.md)
* [Docker](../Applications/Development/Docker/Docker.md)
* [.NET](../Applications/Development/Dotnet/Dotnet.md)

------

### Start hosting services

After setting up the server, you can start hosting services on it. You can refer to the [Servicing guide](./Introduction.md) for more information.
