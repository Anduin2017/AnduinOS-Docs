# WeChat

WeChat is a Chinese multi-purpose messaging, social media and mobile payment app developed by Tencent.

To Install WeChat on AnduinOS, you can run:

```bash
wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -O wechat.deb
sudo dpkg -i wechat.deb
sudo apt install --fix-broken -y
rm wechat.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
