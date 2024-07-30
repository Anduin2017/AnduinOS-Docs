# Nextcloud

Nextcloud is a suite of client-server software for creating and using file hosting services. It is functionally similar to Dropbox, although Nextcloud is free and open-source, allowing anyone to install and operate it on a private server. In contrast to proprietary services the open architecture enables users to have full control of their data. The Nextcloud server is written in the PHP and JavaScript scripting languages. It is built on a LAMP stack, which consists of Linux, Apache, MySQL, and PHP. Nextcloud is extensible via a developer-friendly API for applications and plugins and it works with any storage.

To install Nextcloud Desktop Client on AnduinOS, you can run:

```bash
sudo add-apt-repository -y ppa:nextcloud-devs/client
sudo apt update
sudo apt install nextcloud-desktop nautilus-nextcloud
```

That's it. You can now start using Nextcloud on AnduinOS.

To install Nextcloud CLI client on AnduinOS, you can run:

```bash
sudo apt install nextcloud-client
```

And then you can run `nextcloudcmd` to sync your files with Nextcloud server.

## Nextcloud Server

To install Nextcloud Server on AnduinOS, you can follow the official guide at [Nextcloud Installation](https://docs.nextcloud.com/server/latest/admin_manual/installation/index.html).
