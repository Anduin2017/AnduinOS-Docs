# Manage Swap

Swap is a space on a disk that is used when the amount of physical RAM memory is full. When a Linux system runs out of RAM, inactive pages are moved from the RAM to the swap space.

If your system is running out of memory, you can create a swap file to increase the available memory.

However, for some systems, like distributed database systems, it is recommended to disable swap to avoid random performance issues.

!!! tip "Adjusting swap doesn't require a reboot"

    You can adjust the swap space without rebooting the system.

!!! note "Swap file vs Swap Partition"

    A swap file is a file that is used as a swap space, while a swap partition is a dedicated partition that is used as a swap space.

    A swap file is easier to create and manage than a swap partition, while a swap partition usually has better performance than a swap file.

## Check if swap is enabled

To check if swap is enabled, run the following command:

```bash title="Check if swap is enabled"
sudo swapon --show
```

Also you can use the `free` command to check the overall memory usage and swap usage:

```bash title="Check swap usage"
free -h
```

## Create a swap file

To create a swap file, run the following commands:

```bash title="Create a swap file"
sudo fallocate -l 8G /swapfile # You can change the size and the name of the swap file
sudo chmod 600 /swapfile
sudo mkswap /swapfile
```

To activate the swap file, run the following command:

```bash title="Activate the swap file"
sudo swapon /swapfile
```

To make the swap file permanent, add the following line to the `/etc/fstab` file:

```bash title="Add the swap file to /etc/fstab"
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## Disable swap

To disable the swap, run the following command:

```bash title="Disable swap"
sudo swapoff -v /swapfile
```

To remove the swap file, run the following command:

```bash title="Remove the swap file"
sudo rm /swapfile
```

Don't forget to remove the swap file from the `/etc/fstab` file.

## Totally disable swap

To totally disable swap, you can directly run the following command:

```bash title="Totally disable swap"
sudo swapoff -a
```

And that will disable all swap spaces.
