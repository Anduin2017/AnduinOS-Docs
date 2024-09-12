# Switch to your language

In case you installed AnduinOS with a language that you are not familiar with, you can switch to your preferred language by following the instructions below.

## Step 1: Install language pack

For example, if you want to switch to the Japanese language, you can install the Japanese language pack by running the following command:

```bash title="Install Japanese language pack"
sudo apt install language-pack-ja language-pack-gnome-ja
```

If I want to switch to Simplified Chinese, I can install the Chinese language pack by running the following command:

```bash title="Install Chinese language pack"
sudo apt install language-pack-zh-hans language-pack-gnome-zh-hans
```

## Step 2: Set the language

After installing the language pack, you can set the language by running the following command:

```bash title="Set Japanese language"
sudo update-locale LANG=ja_JP.UTF-8
```

If you want to switch to Simplified Chinese, you can set the language by running the following command:

```bash title="Set Chinese language"
sudo update-locale LANG=zh_CN.UTF-8
```

You can also manually edit the `/etc/default/locale` file and set the `LANG` variable to your preferred language.

For example, if you want to switch to the Japanese language, you can set the `LANG` variable to `ja_JP.UTF-8`.

```bash title="Edit /etc/default/locale to set Language"
sudo nano /etc/default/locale
```

You need to log out and log back in for the changes to take effect.

## Step 3: Edit pam configuration for current user

If your language is not set correctly, you may need to edit the PAM configuration for the current user.

You may also need to edit the PAM configuration to set the correct language. You can do this by editing the `~/.pam_environment` file and adding the following lines:

```bash title="~/.pam_environment to set Japanese"
LANG=ja_JP.UTF-8
LANGUAGE=ja_JP:ja
LC_MESSAGES=ja_JP.UTF-8
```

For example, if I want to set to Chinese, I can set the `LANG` variable to `zh_CN.UTF-8`.

```bash title="~/.pam_environment to set Chinese"
LANG=zh_CN.UTF-8
LANGUAGE=zh_CN:zh
LC_MESSAGES=zh_CN.UTF-8
```

## Step 4: Install correct input method

If you are using a non-English language, you may need to install the correct input method to type in your language.

For example, if you are using the Japanese language, you can install the `ibus-anthy` input method by running the following command:

```bash title="Install Japanese input method anthy"
sudo apt install ibus-anthy
```

If you are using the Chinese language, you can install the `ibus-rime` input method by running the following command:

```bash title="Install Chinese input method rime"
sudo apt install ibus-rime
```

Log out and log back in for the changes to take effect.

You can then configure the input method by going to `Settings -> Keyboard -> Input Sources` and adding the input method for your language.

## Step 5: Switch timezone

You may also want to switch the timezone to your local timezone. You can do this by going to `Settings -> Date & Time` and selecting your local timezone.

Or if you want to switch the timezone using the command line, you can run the following command:

```bash title="Switch to Japanese timezone"
sudo timedatectl set-timezone Asia/Tokyo
```

If you want to switch to the Chinese timezone, you can run the following command:

```bash title="Switch to Chinese timezone"
sudo timedatectl set-timezone Asia/Shanghai
```

To view available timezones, you can run the following command:

```bash title="List available timezones"
ls /usr/share/zoneinfo -R
```

And you can manually edit the `/etc/timezone` file and set the timezone to your preferred timezone.

## Step 6: Switch apt source

You may also want to switch the apt source to a mirror that is closer to your location. You can follow the instructions in the [Select best apt source](./Select-Best-Apt-Source.md) guide to switch the apt source.
