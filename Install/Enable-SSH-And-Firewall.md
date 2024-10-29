# Enable SSH and Firewall

## Enable SSH

SSH is a secure protocol used to connect to remote servers. It is a good practice to enable SSH on your server to allow remote access. To enable SSH, follow the steps below:

```bash
sudo apt update
sudo apt install openssh-server
```

Once the installation is complete, you can check the status of the SSH service using the following command:

```bash
sudo systemctl status ssh
```

You can ssh to localhost to test if the SSH service is working:

```bash
ssh localhost
```

You will be prompted to enter your password. Once you enter the password, you will be connected to the server.

## Enable Firewall

A firewall is a network security system that monitors and controls incoming and outgoing network traffic based on predetermined security rules. To enable the firewall, follow the steps below:

```bash
sudo apt install ufw
sudo ufw allow ssh
sudo ufw enable
```

You can check the status of the firewall using the following command:

```bash
sudo ufw status
```