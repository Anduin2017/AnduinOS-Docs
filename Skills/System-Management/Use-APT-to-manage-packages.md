# How to use apt to manage packages

`apt` is a package manager for Debian-based systems. It is used to install, update, and remove software packages.

## Use for C\C++

By defualt, your C program `#include` will import files under `/usr/include`. And your C++ program `#include` will import files under `/usr/include/c++/version`.

For example, if I want to build a program which should call curl, I need to install `libcurl4-openssl-dev`.

```bash
sudo apt install libcurl4-openssl-dev
```

Then I can build a new C file `check_website.c`:

```c
#include <stdio.h>
#include <curl/curl.h>

int main(void) {
    CURL *curl;
    CURLcode res;
    long http_code = 0;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://www.google.com");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        } else {
            curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
            printf("Response code: %ld\n", http_code);
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
    return 0;
}
```

After installing `libcurl4-openssl-dev gcc build-essential`, I can build the program with:

```bash
gcc ./check_website.c -o check_website -lcurl
```

Then I can run the program with:

```bash
./check_website
200
```

As you can see, the program will print `200` which means the website is OK.

C\C++ program is very happy to use `apt` to install the dependencies.

## Basic usages

Right here covers basic daily usages of `apt`. Including:

* Install a package
* Uninstall a package
* Upgrade all installed packages
* Search new packages
* List all installed packages

### Install

To install a new package, use the `install` command followed by the package name.

```bash
sudo apt install package-name
```

Example:

```bash
sudo apt install git
```

### Remove

`apt remove` will only remove one package. It will not remove any packages that were installed as dependencies.

For example, some packages were automatically installed and are no longer required. `apt remove` will not remove them.

```bash
anduin@host $ sudo apt remove git
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer required:
  bup-doc git-man liberror-perl python3-distupgrade python3-fuse python3-pylibacl python3-pyxattr python3-update-manager ubuntu-release-upgrader-core
Use 'sudo apt autoremove' to remove them.
The following packages will be REMOVED:
  git
0 upgraded, 0 newly installed, 1 to remove and 22 not upgraded.
After this operation, 19.6 MB disk space will be freed.
```

Usually it's not suggested to use `apt remove` because it will not remove the packages that were installed as dependencies. `apt autoremove` is suggested to remove the packages that are no longer needed.

### Autoremove

Autoremove will remove the package and all packages that were installed as dependencies but are no longer needed.

```bash
sudo apt autoremove git
```

This command will remove the `git` package and all packages that were installed as dependencies but are no longer needed.

```bash
anduin@u-real:~$ sudo apt autoremove git
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be REMOVED:
  bup bup-doc git git-man liberror-perl python3-distupgrade python3-fuse python3-pylibacl python3-pyxattr python3-update-manager ubuntu-release-upgrader-core
0 upgraded, 0 newly installed, 11 to remove and 22 not upgraded.
After this operation, 23.4 MB disk space will be freed.
Do you want to continue? [Y/n]
```

`apt autoremove` can also be used without a package name. It will remove all packages that are no longer needed.

Inside apt, there is a reference-counting mechanism to track the number of packages that depend on a package. When a package is removed, the reference count is decreased. When the reference count reaches zero, the package is no longer needed and can be `autoremoved`.

```bash
anduin@host:~$ sudo apt autoremove
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be REMOVED:
  python3-distupgrade python3-update-manager ubuntu-release-upgrader-core
0 upgraded, 0 newly installed, 3 to remove and 22 not upgraded.
After this operation, 1,270 kB disk space will be freed.
Do you want to continue? [Y/n] 
(Reading database ... 338310 files and directories currently installed.)
Removing ubuntu-release-upgrader-core (1:22.04.19) ...
Removing python3-distupgrade (1:22.04.19) ...
Removing python3-update-manager (1:22.04.20) ...
Processing triggers for man-db (2.10.2-1) ...
```

### Remove\Autoremove with --purge

`--purge` is an argument that can be used with `apt remove` and `apt autoremove`. It will remove the package and all configuration files.

```bash
sudo apt     remove --purge git
sudo apt autoremove --purge git
```

If you don't want to keep the configuration files, use `--purge`.

`apt purge` is actually the same as `apt remove --purge`. Here `purge` is just a shorthand for `remove --purge`.

Unlike `autoremoving` can run without a package name, `purging` must have a package name.

### Update

`apt update` is used to update the package list. It will download the latest package list from the repositories.

```bash
sudo apt update
```

It is required to run `apt update` before running other commands because only `apt update` will download the latest package list from the repositories.

`apt update` will read the sources at `/etc/apt/sources.list` and `/etc/apt/sources.list.d/` and download the latest package list from the repositories.

```bash
anduin@host:~$ cat /etc/apt/sources.list
deb http://mirror.aiursoft.cn/ubuntu/ jammy main restricted universe multiverse
deb http://mirror.aiursoft.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirror.aiursoft.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb http://mirror.aiursoft.cn/ubuntu/ jammy-security main restricted universe multiverse

anduin@host:$ cat /etc/apt/sources.list.d/google-earth-pro.list
deb [arch=amd64] http://dl.google.com/linux/earth/deb/ stable main
```

You can add thrird-party repositories to `/etc/apt/sources.list.d/` and run `apt update` to download the latest package list from the third-party repositories.

`apt update` takes no arguments.

### Upgrade

`apt upgrade` is used to upgrade the installed packages to the latest version.

```bash
sudo apt upgrade
```

### Search

`apt search` is used to search for packages.

```bash
sudo apt search dotnet
```

This will output a list of packages that match the search term.

### List

`apt list` is used to list all packages. `apt list` is similar to `apt search`, but it will list all packages matches the search term. Like `dotnet*` will list all packages that start with `dotnet`.

```bash
anduin@host:/etc/apt/sources.list.d$ sudo apt list dotnet*
Listing... Done
dotnet-apphost-pack-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-apphost-pack-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-apphost-pack-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-host-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-host-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-host/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-hostfxr-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-hostfxr-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-hostfxr-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-runtime-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-runtime-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-runtime-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-runtime-dbg-8.0/jammy-updates,jammy-security 8.0.7-0ubuntu1~22.04.1 amd64
dotnet-sdk-6.0-source-built-artifacts/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-sdk-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-sdk-7.0-source-built-artifacts/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-sdk-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-sdk-8.0-source-built-artifacts/jammy-updates,jammy-security 8.0.107-0ubuntu1~22.04.1 amd64
dotnet-sdk-8.0/jammy-updates,jammy-security,now 8.0.107-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-sdk-dbg-8.0/jammy-updates,jammy-security 8.0.107-0ubuntu1~22.04.1 amd64
dotnet-targeting-pack-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-targeting-pack-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-targeting-pack-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-templates-6.0/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet-templates-7.0/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet-templates-8.0/jammy-updates,jammy-security,now 8.0.107-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet6/jammy-updates,jammy-security 6.0.132-0ubuntu1~22.04.1 amd64
dotnet7/jammy-updates,jammy-security 7.0.119-0ubuntu1~22.04.1 amd64
dotnet8/jammy-updates,jammy-security,now 8.0.107-8.0.7-0ubuntu1~22.04.1 amd64 [installed]
```

`apt list` can also be used without a package name. It will list all packages.

More commonly, `apt list` is used to list all packages installed on the system.

```bash
sudo apt list --installed
```

For example, if I want to list all `dotnet*` on my system, I can use `apt list --installed dotnet*`.

```bash
anduin@u-real:/etc/apt/sources.list.d$ sudo apt list dotnet* --installed
Listing... Done
dotnet-apphost-pack-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-host-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-hostfxr-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-runtime-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-sdk-8.0/jammy-updates,jammy-security,now 8.0.107-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-targeting-pack-8.0/jammy-updates,jammy-security,now 8.0.7-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet-templates-8.0/jammy-updates,jammy-security,now 8.0.107-0ubuntu1~22.04.1 amd64 [installed,automatic]
dotnet8/jammy-updates,jammy-security,now 8.0.107-8.0.7-0ubuntu1~22.04.1 amd64 [installed]
```

### Show

In some cases, I need to know the details of a package. `apt show` is used to show the details of a package.

```bash
anduin@host:/etc/apt/sources.list.d$ sudo apt show git
Package: git
Version: 1:2.34.1-1ubuntu1.11
Priority: optional
Section: vcs
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Jonathan Nieder <jrnieder@gmail.com>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 18.9 MB
Provides: git-completion, git-core
Depends: libc6 (>= 2.34), libcurl3-gnutls (>= 7.56.1), libexpat1 (>= 2.0.1), libpcre2-8-0 (>= 10.34), zlib1g (>= 1:1.2.0), perl, liberror-perl, git-man (>> 1:2.34.1), git-man (<< 1:2.34.1-.)
Recommends: ca-certificates, patch, less, ssh-client
Suggests: gettext-base, git-daemon-run | git-daemon-sysvinit, git-doc, git-email, git-gui, gitk, gitweb, git-cvs, git-mediawiki, git-svn
Breaks: bash-completion (<< 1:1.90-1), cogito (<= 0.18.2+), dgit (<< 5.1~), git-buildpackage (<< 0.6.5), git-el (<< 1:2.32.0~rc2-1~), gitosis (<< 0.2+20090917-7), gitpkg (<< 0.15), guilt (<< 0.33), openssh-client (<< 1:6.8), stgit (<< 0.15), stgit-contrib (<< 0.15)
Homepage: https://git-scm.com/
Task: cloud-image, ubuntu-wsl, server, ubuntu-server-raspi, kubuntu-desktop, lubuntu-desktop, ubuntustudio-desktop-core, ubuntustudio-desktop
Download-Size: 3,165 kB
APT-Manual-Installed: yes
APT-Sources: http://mirror.aiursoft.cn/ubuntu jammy-updates/main amd64 Packages
Description: fast, scalable, distributed revision control system
 Git is popular version control system designed to handle very large
 projects with speed and efficiency; it is used for many high profile
 open source projects, most notably the Linux kernel.
 .
 Git falls in the category of distributed source code management tools.
 Every Git working directory is a full-fledged repository with full
 revision tracking capabilities, not dependent on network access or a
 central server.
 .
 This package provides the git main components with minimal dependencies.
 Additional functionality, e.g. a graphical user interface and revision
 tree visualizer, tools for interoperating with other VCS's, or a web
 interface, is provided as separate git* packages.

N: There is 1 additional record. Please use the '-a' switch to see it
```

As you can see here, `apt show` also shows the dependencies, the size of the package, the origin, the maintainer, the homepage, and the description of the package.

If you run `apt install git` here, it will also install the dependencies, including `libc6`, `libcurl3-gnutls`, `libexpat1`, `libpcre2-8-0`, `zlib1g`, `perl`, `liberror-perl`, and `git-man`.

And you can not remove a dependency package without removing the package that depends on it. For example, you can not remove `libc6` without removing `git`.

```bash
anduin@host:/etc/apt/sources.list.d$ sudo apt autoremove git-man
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be REMOVED:
  bup bup-doc ****git**** git-man liberror-perl python3-fuse python3-pylibacl python3-pyxattr
0 upgraded, 0 newly installed, 8 to remove and 3 not upgraded.
After this operation, 22.2 MB disk space will be freed.
Do you want to continue? [Y/n] 
```

In this case, `git-man` is a dependency of `git`. If you remove `git-man`, `git` will also be removed.

### Clean

`apt clean` is used to clean the cache. It will remove all downloaded packages from the cache.

```bash
sudo apt clean
```

## Advanced usages

Right here covers advanced usages of `apt`.

### Pinning

Pinning is an advanced usage that allows you to control which versions of packages are installed on your system. You can specify preferences for package versions by creating or editing files in /etc/apt/preferences.d/.

To pin a specific package version, create a file in `/etc/apt/preferences.d/` with the following format:

```plaintext
Package: package-name
Pin: version x.y.z
Pin-Priority: 1001
```

Example for pinning git to version 2.34.1:

```plaintext
Package: git
Pin: version 2.34.1
Pin-Priority: 1001
```

Save this configuration in a file, such as /etc/apt/preferences.d/git.

You can also use this trick to avoid installing a specific package or version. For example, to avoid installing snapd, you can create a file in /etc/apt/preferences.d/ with the following content:

```bash
cat << EOF > /etc/apt/preferences.d/no-snap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

### Check the files inside a package

`apt-file` is a tool that can be used to check the files inside a package.

```bash
sudo apt install apt-file
```

After installing `apt-file`, you need to update the package list.

```bash
sudo apt-file update
```

Then you can use `apt-file` to check the files inside a package.

```bash
anduin@host:~$ apt-file list ubuntu-wallpapers
ubuntu-wallpapers: /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png
ubuntu-wallpapers: /usr/share/backgrounds/warty-final-ubuntu.png
ubuntu-wallpapers: /usr/share/doc/ubuntu-wallpapers/changelog.Debian.gz
ubuntu-wallpapers: /usr/share/doc/ubuntu-wallpapers/copyright
ubuntu-wallpapers: /usr/share/gnome-background-properties/ubuntu-wallpapers.xml
```

As you can see above, `ubuntu-wallpapers` contains the files for `/usr/share/backgrounds` and `/usr/share/gnome-background-properties`.

### Query which packages depend on a package

`apt-cache` is a tool that can be used to query which packages depend on a package.

```bash
apt-cache rdepends package-name
```

For example, to query which packages depend on `ubuntu-wallpapers`, you can use the following command:

```bash
anduin@u-real:~$ apt-cache rdepends ubuntu-wallpapers
ubuntu-wallpapers
Reverse Depends:
  ubuntu-wallpapers-xenial
  ubuntu-desktop-minimal
  ubuntu-desktop
  gnome-shell
  ubuntu-wallpapers-xenial
  ubuntu-wallpapers-focal
  ubuntu-wallpapers-focal
  ubuntu-wallpapers-eoan
  ubuntu-wallpapers-eoan
  ubuntu-wallpapers-cosmic
  ubuntu-wallpapers-disco
  ubuntu-wallpapers-disco
  ubuntu-wallpapers-cosmic
  gnome-shell
  ubuntu-artwork
  ubuntu-desktop-minimal
  ubuntu-desktop
```

### Adding new repositories

Before starting, to have the `add-apt-repository` command, you need to install `software-properties-common`.

```bash
sudo apt install software-properties-common
```

For example, if you want to install nextcloud, you may want to:

```bash
sudo add-apt-repository -y ppa:nextcloud-devs/client
```

And then you can install nextcloud-client with:

```bash
sudo apt install nextcloud-client
```

Here are other examples:

```bash
sudo add-apt-repository -y ppa:mozillateam/ppa # Firefox
sudo add-apt-repository -y ppa:apandada1/plots # Plots
sudo add-apt-repository -y multiverse -n
sudo add-apt-repository -y universe -n
sudo add-apt-repository -y restricted -n
```

To query added repositories, you can use:

```bash
cd /etc/apt/sources.list.d/
ls
```

### Setting up your own apt mirror

Reference [here](https://anduin.aiursoft.cn/post/2024/2/8/setup-a-ubuntu-apt-mirror-server)
