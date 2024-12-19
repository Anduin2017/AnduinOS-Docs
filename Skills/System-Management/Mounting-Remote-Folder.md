# Mounting Remote Folders

When working with data, you might need to access files and folders stored on remote machines or servers. Mounting remote folders allows you to access the data as if it were stored locally. This guide will show you how to mount remote folders using different protocols.

## SMB

To mount a remote drive using the SMB protocol, you need to install the `cifs-utils` package. You can install it using the following command:

```bash
sudo apt install cifs-utils
```

Then, you can add the following line to your `/etc/fstab` file to mount the remote drive on boot:

```bash
//SERVER/path /mnt/local_smb cifs username=USER,password=PASSWORD,iocharset=utf8,vers=3.0,file_mode=0666,dir_mode=0777 0 0
```

Where the `SERVER` is the IP address or hostname of the remote server, `path` is the path to the shared folder, `USER` and `PASSWORD` are the credentials to access the shared folder, and `/mnt/local_smb` is the local mount point.

Then, you can mount the remote drive by running:

```bash
sudo mkdir /mnt/local_smb
sudo mount /mnt/local_smb
sudo ls /mnt/local_smb
```

This will mount the remote drive on your local machine, and you can access the data in the shared folder.

!!! warning "Security Risk"

    In the example above, we set `file_mode` and `dir_mode` to `0666` and `0777`, which means giving read and write permissions to everyone. This is only for convenience and might not be secure. You should adjust the permissions according to your needs and security requirements.

!!! note "Wondering how to host a shared SMB folder?"

    Check out our guide on [Setting Up an SMB Share](../../Servicing/Samba/Samba.md) to learn how to host a shared folder on AnduinOS!

## NFS

To mount a remote drive using the NFS protocol, you need to install the `nfs-common` package. You can install it using the following command:

```bash
sudo apt install nfs-common
```

Then, you can add the following line to your `/etc/fstab` file to mount the remote drive on boot:

```bash
SERVER:/path /mnt/local_nfs nfs defaults 0 0
```

Where `SERVER` is the IP address or hostname of the NFS server, and `path` is the path to the shared folder. `/mnt/local_nfs` is the local mount point.

To mount the remote drive, run:

```bash
sudo mkdir /mnt/local_nfs
sudo mount /mnt/local_nfs
sudo ls /mnt/local_nfs
```

This will mount the NFS shared folder on your local machine, allowing you to access its contents.

## WebDAV

To mount a remote drive using the WebDAV protocol, you need to install the `davfs2` package. You can install it using the following command:

```bash
sudo apt install davfs2
```

Then, you can add the following line to your `/etc/fstab` file to mount the remote drive on boot:

```bash
https://SERVER/path /mnt/local_webdav davfs rw,user,uid=USER,gid=GROUP 0 0
```

Where `SERVER` is the hostname of the WebDAV server, `path` is the path to the shared folder, `/mnt/local_webdav` is the local mount point, and `USER` and `GROUP` represent the desired ownership.

To mount the remote drive, run:

```bash
sudo mkdir /mnt/local_webdav
sudo mount /mnt/local_webdav
sudo ls /mnt/local_webdav
```

This will mount the WebDAV folder, allowing you to interact with it as a local drive.

## SSHFS

To mount a remote drive using SSHFS, you need to install the `sshfs` package. You can install it using the following command:

```bash
sudo apt install sshfs
```

Then, you can mount the remote directory with the following command:

```bash
sshfs USER@SERVER:/path /mnt/local_sshfs
```

Where `USER` is your SSH username, `SERVER` is the IP address or hostname of the remote server, and `path` is the directory you want to mount. `/mnt/local_sshfs` is the local mount point.

To make the mount persistent, you can add the following line to your `/etc/fstab` file:

```bash
USER@SERVER:/path /mnt/local_sshfs fuse.sshfs defaults 0 0
```

To mount the drive manually, run:

```bash
sudo mkdir /mnt/local_sshfs
sudo mount /mnt/local_sshfs
sudo ls /mnt/local_sshfs
```

## FTP

To mount a remote drive using FTP, you can use `curlftpfs`. First, install it using:

```bash
sudo apt install curlftpfs
```

Then, mount the remote directory with the following command:

```bash
curlftpfs ftp://USER:PASSWORD@SERVER/path /mnt/local_ftp
```

Where `USER` and `PASSWORD` are the FTP credentials, `SERVER` is the hostname or IP of the FTP server, and `path` is the folder to mount. `/mnt/local_ftp` is the local mount point.

To make the mount persistent, you can add the following line to your `/etc/fstab` file:

```bash
curlftpfs#ftp://USER:PASSWORD@SERVER/path /mnt/local_ftp fuse rw,uid=USER,gid=GROUP 0 0
```

To mount the drive manually, run:

```bash
sudo mkdir /mnt/local_ftp
sudo mount /mnt/local_ftp
sudo ls /mnt/local_ftp
```

This will allow you to access the FTP server as a local drive.
