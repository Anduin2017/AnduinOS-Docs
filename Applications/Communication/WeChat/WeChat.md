# WeChat

WeChat is a Chinese multi-purpose messaging, social media and mobile payment app developed by Tencent.

To Install WeChat on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install -y libxcb-icccm4
wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -O wechat.deb
sudo apt install ./wechat.deb -y
rm wechat.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

## Third-party repository

If you want to automatically update via `sudo apt upgrade`, you can try adding [wcbing APT Repo](https://packages.wcbing.top/deb/). This is a third-party software repository that is updated more timely. 

If you have not added it before, please follow the steps below:

```sh
curl -O https://packages.wcbing.top/deb/wcbing-keyring.deb
sudo apt install ./wcbing-keyring.deb
rm ./wcbing-keyring.deb
```

Then, you can install via apt:

```sh
sudo apt update
sudo apt install wechat
```

!!! warning "This is a third-party repository"

    This is a repository maintained by third-party, and AnduinOS does not make any guarantees for it.

    The author stadeclared that he used index redirection to allow users to download directly from the official distribution of the software, ensuring the security and legality of the source of the software package.

