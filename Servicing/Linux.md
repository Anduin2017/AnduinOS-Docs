# Setup a new Linux server after buying from an external provider

If you have bought a server from an external provider, usually it's not following the Linux authentication best practices. You need to set it up properly before hosting services on it.

## Authentication

### Connect to the server

After buying a server, it will provide you:

* IP address
* Username
* Password

So you can connect to the server using SSH. For example:

```bash title="Connect to the server (Run on your local machine)"
ssh root@your-server-ip
```

------

### Change hostname

By default, the hostname of the server is usually not set properly. You can change it by running:

```bash title="Change hostname"
sudo hostnamectl set-hostname your-hostname
sudo reboot
```

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
sudo whoami
```

------

### Copy SSH public key

!!! note "Run on your local machine!"

    The next command should be run on your local machine instead of the server!

By default, the server provider will give you a password to connect to the server. It's recommended to use [SSH key](../Skills/Secret-Management/Manage-SSH-Keys.md) instead. You can generate a new SSH key pair on your local machine:

!!! warning "Generate a new SSH key pair"

    Don't overwrite the existing SSH key pair if you already have one!

    The command above will overwrite the existing SSH key pair. You can check if you already have an SSH key pair by running:

    ```bash
    ls ~/.ssh
    ```

```bash title="Generate a new SSH key pair"
ssh-keygen
```

Then copy the public key to the server:

```bash title="Copy SSH public key"
ssh-copy-id your-username@your-server-ip
```

Now you can connect to the server without a password:

```bash title="Connect to the server without password (Run on your local machine)"
ssh your-username@your-server-ip
```

------

### Disable root login

It's not recommended to allow root login via SSH. You should disable it by editing the SSH configuration file:

```bash title="Disable root login"
sudo vim /etc/ssh/sshd_config
```

* Change: `PermitRootLogin` to `no` to disable the root user login.
* Change `PasswordAuthentication`  to `no` to prevent the password login.
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

* root
* sync (1)
* your-username

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

------

### Enable cake for better QoS

CAKE is a queuing discipline that can improve network performance. You can enable it by running:

```bash title="Enable Cake"
enable_cake()
{
    echo "Cake not enabled. Enabling Cake..."
    echo 'net.core.default_qdisc=cake' | sudo tee /etc/sysctl.conf
    sudo sysctl -p
    echo "Cake enabled. Reboot to take effect."
}
sudo sysctl net.core.default_qdisc | grep -q cake ||  enable_cake
```

------

### Setup best apt mirror

By default, the server provider may not set the best apt mirror for you. You can set it by running:

```bash title="Set best apt mirror"
function switchSource() {
  mirrors=(
      "http://archive.ubuntu.com/ubuntu/"
      "http://sg.archive.ubuntu.com/ubuntu/" # Singapore
      "http://jp.archive.ubuntu.com/ubuntu/" # Japan
      "http://kr.archive.ubuntu.com/ubuntu/" # Korea
      "http://us.archive.ubuntu.com/ubuntu/" # United States
      "http://ca.archive.ubuntu.com/ubuntu/" # Canada
      "http://tw.archive.ubuntu.com/ubuntu/" # Taiwan (Province of China)
      "http://th.archive.ubuntu.com/ubuntu/" # Thailand
      "http://de.archive.ubuntu.com/ubuntu/" # Germany
      "https://ubuntu.mirrors.uk2.net/ubuntu/" # United Kingdom
      "http://ubuntu.mirror.cambrium.nl/ubuntu/" # Netherlands
      "http://mirrors.ustc.edu.cn/ubuntu/" # 中国科学技术大学
      "http://ftp.sjtu.edu.cn/ubuntu/" # 上海交通大学
      "http://mirrors.tuna.tsinghua.edu.cn/ubuntu/" # 清华大学
      "http://mirrors.aliyun.com/ubuntu/" # Aliyun
      "http://mirrors.163.com/ubuntu/" # NetEase
      "http://mirrors.cloud.tencent.com/ubuntu/" # Tencent Cloud
      "http://mirror.aiursoft.cn/ubuntu/" # Aiursoft
      "http://mirrors.huaweicloud.com/ubuntu/" # Huawei Cloud
      "http://mirrors.zju.edu.cn/ubuntu/" # 浙江大学
      "http://azure.archive.ubuntu.com/ubuntu/" # Azure
  )

  declare -A results

  test_speed() {
      url=$1
      response=$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" --connect-timeout 1 --max-time 5 "$url")
      http_code=$(echo $response | awk '{print $1}')
      time_total=$(echo $response | awk '{print $2}')

      if [ "$http_code" -eq 200 ]; then
          results["$url"]=$time_total
      else
          echo "Failed to access $url"
          results["$url"]="9999"
      fi
  }

  echo "Testing all mirrors..."
  for mirror in "${mirrors[@]}"; do
      test_speed "$mirror"
  done

  sorted_mirrors=$(for url in "${!results[@]}"; do echo "$url ${results[$url]}"; done | sort -k2 -n)

  echo "Sorted mirrors:"
  echo "$sorted_mirrors"

  fastest_mirror=$(echo "$sorted_mirrors" | head -n 1 | awk '{print $1}')

  echo "Fastest mirror: $fastest_mirror"
  echo "
  deb $fastest_mirror jammy main restricted universe multiverse
  deb $fastest_mirror jammy-updates main restricted universe multiverse
  deb $fastest_mirror jammy-backports main restricted universe multiverse
  deb $fastest_mirror jammy-security main restricted universe multiverse
  " | sudo tee /etc/apt/sources.list
}

sudo apt update
sudo apt install curl -y
switchSource
```

That command will test all mirrors and set the fastest one for you.

------

## Security

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
sudo do_anduinos_upgrade
sudo apt --purge autoremove -y" | sudo tee /usr/local/bin/update.sh
sudo chmod +x /usr/local/bin/update.sh
(crontab -l ; echo "0 2 * * 0 /usr/local/bin/update.sh") | crontab -
```

------

## Performance

### Install latest kernel

By default, the server provider may not install the latest kernel for you. For example, by default, Ubuntu 22.04 may provide the 5.15 kernel, but the latest kernel is 6.*.

!!! warning "Kernel version"

    The kernel version may vary depending on the Ubuntu version. You should check the latest kernel version for your Ubuntu version.

    It is always recommended to use a newer kernel for better performance and security, especially if you are using a server with newer hardware.

To verify the current kernel version, you can run:

```bash title="Check current kernel version"
uname -r
```

You can install the latest kernel by running:

```bash title="Install latest kernel"
sudo apt install -y linux-generic-hwe-22.04
sudo reboot
```

!!! note "Command only for Ubuntu 22.04"

    The command above is only for Ubuntu 22.04. For other versions, you can search for the latest kernel package.

------

### Tune CPU from power-saver to performance

If you are running on a bare-metal server, you can tune the CPU from power-saver to performance to get better performance:

```bash title="Tune CPU to performance"
sudo apt install -y linux-tools-common linux-tools-generic
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
iperf3 -s
```

Then on your local machine, you can run:

```bash title="Test network speed"
iperf3 -c your-server-ip
```

To use `sysbench` to test the CPU performance:

```bash title="Test CPU performance"
sudo apt install -y sysbench
sysbench cpu --threads=64 run
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