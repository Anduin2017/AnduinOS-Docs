# Factory reset AnduinOS Desktop settings

In some cases, you might mess up your desktop settings and want to reset them to the default settings. This document will guide you through the process of resetting your desktop settings.

To reset your desktop settings, you can run:

```bash title="Reset Desktop Settings"
curl -sL https://gitlab.aiursoft.cn/anduin/anduinos/-/raw/master/src/patches/dconf/dconf.ini?ref_type=heads | dconf load /org/gnome/
```

This command WILL reset your desktop settings to the AnduinOS default settings, including:

* Wallpaper
* Theme
* Icons
* Fonts
* Start menu
* Taskbar

And:

* This command will NOT remove any application, data, or configuration files.
* This command will NOT install missing applications, gnome extensions, or themes.
* This command will NOT reset your applications' settings or configurations.
