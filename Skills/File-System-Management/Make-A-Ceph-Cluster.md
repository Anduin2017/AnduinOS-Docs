# Ceph Cluster Deployment Guide

In some cases, like you have a large amount of data to store and manage, you may need a distributed storage system. Ceph is a popular choice for this purpose. It is a unified, distributed storage system designed for excellent performance, reliability, and scalability.

This document outlines the step-by-step procedure to deploy a Ceph cluster on three nodes (node1, node2, and node3). Each node should have a **new, large hard disk** (e.g., `/dev/sdb`) dedicated to Ceph. All commands must be executed as the root user.

!!! note "Ceph requires root privileges"

    Although running commands as root is generally discouraged in Linux best practices, Ceph requires root privileges for many of its operations.

## 1. Prerequisites

- **Nodes:**
  - Three physical servers (recommended) or virtual machines with appropriate disk I/O configurations.
  - Hostnames: `node1`, `node2`, and `node3`.

- **Networking:**
  - All nodes must have full network connectivity without intervening firewalls.

- **User Permissions:**
  - All commands should be run as root. You can switch to root with:

```bash title="Switch to root"
sudo su
```

## 2. Enable Root SSH Access

Ceph’s orchestration components utilize root SSH to execute commands on remote nodes. Adjust the SSH daemon configuration on each node:

```bash title="Edit SSH configuration"
vim /etc/ssh/sshd_config
```

- Set `PermitRootLogin` to `yes`.
- Set `PasswordAuthentication` to `yes`.

```bash title="Restart SSH service"
systemctl restart sshd
```

!!! warning "Security Consideration"

    Enabling root SSH with password authentication is not recommended for production environments due to security concerns. Ensure that this setup is only used in a controlled environment.

## 3. Update Root Password

Set a strong root password on each node:

```bash
passwd
```

## 4. Stop Conflicting Services (Optional)

!!! note "Skip this step if you are deploying on new servers"

    If your nodes previously used storage solutions such as GlusterFS or Docker stacks, stop and disable these services to avoid conflicts:

If your nodes previously used storage solutions such as GlusterFS or Docker stacks, stop and disable these services to avoid conflicts:

Remove Docker stacks:

```bash title="(Optional) Remove Docker stacks"
docker stack rm $(docker stack ls --format '{{.Name}}')
```

Stop and disable GlusterFS:

```bash title="(Optional) Stop and disable GlusterFS"
systemctl stop glusterd
systemctl disable glusterd
```

## 5. Prepare the Disk

Wipe the disk **on each node** to ensure a clean state. **Backup any important data before proceeding.**

```bash title="Wipe the disk"
fdisk /dev/sdb
```

Within `fdisk`, perform the following actions:

- **d:** Delete any existing partitions.
- **g:** Create a new GPT partition table.
- **w:** Write the changes and exit.

## 6. Prepare Ceph Configuration Files

Create the Ceph configuration directory **on each node**:

```bash title="Create the Ceph configuration directory"
mkdir -p /etc/ceph
```

Install Docker **on each node**:

Ceph’s deployment mechanism uses Docker to manage its components.

```bash title="Install Docker"
curl -fsSL get.docker.com -o get-docker.sh
CHANNEL=stable sh get-docker.sh
rm get-docker.sh
```

## 7. Bootstrap the Ceph Cluster

Perform the initial Ceph bootstrap on `node1` only:

```bash title="Download the Cephadm binary"
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/octopus/src/cephadm/cephadm
chmod +x cephadm
```

```bash title="Create the Ceph configuration directory"
mkdir -p /etc/ceph
```

Replace `$MYIP` with the internal IP address of `node1`.

```bash title="Bootstrap Ceph"
./cephadm bootstrap --mon-ip $MYIP
```

Allow approximately 90 seconds for the bootstrap process to complete. **Note the output**—it contains essential configuration details.

## 8. Distribute Configuration Files

After bootstrapping on `node1`, copy the configuration and keyring files to `node2` and `node3`:

```bash
scp /etc/ceph/ceph.conf root@node2:/etc/ceph/ceph.conf
scp /etc/ceph/ceph.conf root@node3:/etc/ceph/ceph.conf
scp /etc/ceph/ceph.client.admin.keyring root@node2:/etc/ceph/ceph.client.admin.keyring
scp /etc/ceph/ceph.client.admin.keyring root@node3:/etc/ceph/ceph.client.admin.keyring
scp /etc/ceph/ceph.pub root@node2:/root/.ssh/authorized_keys
scp /etc/ceph/ceph.pub root@node3:/root/.ssh/authorized_keys
```

Install Ceph common tools on `node1`:

```bash title="Install Ceph common tools"
apt install -y ceph-common
```

## 9. Add Nodes to the Cluster

Use Ceph’s orchestration commands to register additional hosts:

```bash title="Add nodes to the cluster"
ceph orch host add node2
ceph orch host add node3
ceph orch host ls
```

## 10. Configure and Add OSDs

### Automatic Device Detection

Instruct Ceph to automatically discover and configure available devices:

```bash title="Automatic device detection"
ceph orch apply osd --all-available-devices
```

### Manual Device Preparation (if necessary)

If automatic detection encounters issues, manually prepare each disk by “zapping” the device to clear any existing data:

```bash title="Manual device preparation"
ceph orch device zap node1 /dev/sdb --force
ceph orch device zap node2 /dev/sdb --force
ceph orch device zap node3 /dev/sdb --force
```

## 11. Mount the Ceph File System

Finally, configure and mount the CephFS file system:

Append an entry to `/etc/fstab`:

```bash title="Append an entry to /etc/fstab"
echo "
# Mount CephFS
node1,node2,node3:/ /swarm-vol ceph name=admin,noatime,_netdev 0 0
" | tee -a /etc/fstab
```

Create the mount point and mount the file system:

```bash title="Create the mount point and mount the file system"
mkdir -p /swarm-vol
mount /swarm-vol
```

## Summary

This document has detailed the necessary steps to deploy a Ceph cluster on three nodes with a new dedicated disk on each. It covers SSH configuration, service shutdown for conflicting systems, disk preparation, Ceph bootstrapping, configuration distribution, host registration, OSD deployment, and CephFS mounting.

For further customization or troubleshooting, refer to the official [Ceph documentation](https://docs.ceph.com/) and the Ceph community resources.
