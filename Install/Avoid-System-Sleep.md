# Avoid System Sleep

In some cases, you might need your computer always to be awake. For example, you might need to download a large file, run a long-running task, or keep your computer awake for a presentation. In this guide, we will show you how to avoid system sleep on AnduinOS.

## Configure auto lock settings

!!! warning "Configure auto lock settings"

    Avoiding auto lock can cause your computer to be vulnerable to unauthorized access. We recommend using this feature only when necessary. For example, running as kiosk mode.

To configure auto lock settings, you can follow these steps:

1. Open the **Settings** app.
2. Click on **Privacy**.
3. Click on **Screen**.
4. Set the **Automatic Screen Lock** toggle to **ON** or **OFF**.

To configure the time before the screen locks, you can set the **Automatic Screen Lock Delay** to the desired time.

To setup auto lock in the terminal, you can run the following command:

```bash
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay <time-in-seconds-after-screen-blanking>
```

## Avoid screen blanking using the terminal

!!! warning "Avoid screen blanking using the terminal"

    Avoiding screen blanking can cause your computer to consume more power and may damage your screen. (Especially OLED screens) We strongly recommend using this feature only when necessary. For example, running a presentation or watching a movie.

To avoid screen blanking using the terminal, you can run the following command:

```bash
gsettings set org.gnome.desktop.session idle-delay 0
```

This command will prevent the screen from blanking when the computer is inactive.

To revert the changes, you can run the following command:

```bash
gsettings set org.gnome.desktop.session idle-delay 300
```

This command will allow the screen to blank after 5 minutes of inactivity. You can change the value to any number you want.

## Avoid system sleep using the terminal

!!! warning "Avoid system sleep using the terminal"

    Avoiding system sleep can cause your computer to consume more power. We recommend using this feature only when necessary. For example, running virtual machines, downloading large files, or hosting a server.

To avoid system sleep using the terminal, you can run the following command:

```bash
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
```

This command will prevent the system from sleeping when the computer is inactive while connected to AC power.

To revert the changes, you can run the following command:

```bash
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
```

This command will allow the system to sleep when the computer is inactive while connected to AC power.

Also, you can set how long the system should wait before going to sleep when the computer is inactive while connected to AC power. To set the time, you can run the following command:

```bash
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout <time-in-seconds>
```

## References

Default settings for AnduinOS:

* Auto dim after inactivity: 15 minutes
* Auto sleep after inactivity: 30 minutes
* Lock screen right after screen is blanked.
* Power button action: Suspend(sleep)
* Lid close action: Suspend(sleep)

| Settings Path                                  | Settings Key                             | Explanation                                                                                        | Default Value              |
| ---------------------------------------------- | ---------------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------- |
| org.gnome.desktop.session                      | idle-delay                               | The time in seconds before the system is considered idle.                                          | 900                        |
| org.gnome.settings-daemon.plugins.power        | idle-dim                                 | Enables dimming the screen when idle to save power.                                                | true                       |
| org.gnome.settings-daemon.plugins.power        | idle-brightness                          | The brightness level (percentage) when the screen is dimmed due to inactivity.                     | 30                         |
| org.gnome.settings-daemon.plugins.power        | sleep-inactive-ac-timeout                | The time in seconds before the system automatically suspends when inactive and on AC power.        | 1800                       |
| org.gnome.settings-daemon.plugins.power        | sleep-inactive-ac-type                   | The action performed when the system is inactive and on AC power.                                  | 'suspend'                  |
| org.gnome.settings-daemon.plugins.power        | power-button-action                      | The action performed when the power button is pressed.                                             | 'suspend'                  |
| org.gnome.settings-daemon.plugins.power        | lid-close-ac-action                      | The action performed when the laptop lid is closed while on AC power.                              | 'suspend'                  |
| org.gnome.settings-daemon.plugins.power        | lid-close-suspend-with-external-monitor  | Disables suspend when the laptop lid is closed with an external monitor connected.                 | false                      |
| org.gnome.settings-daemon.plugins.power        | ambient-enabled                          | Enables the ambient light sensor to automatically adjust the brightness of the display.            | true                       |
| org.gnome.desktop.screensaver                  | lock-enabled                             | Enables the auto lock screen feature when the screen is blanked.                                   | true                       |
| org.gnome.desktop.screensaver                  | lock-delay                               | Number of seconds after the screen is blank before locking the screen                              | uint32 0                   |
| org.gnome.desktop.screensaver                  | logout-enabled                           | Disables automatic logout after a period of inactivity.                                            | false                      |

To get the value of a setting, you can run the following command:

```bash title="Get settings value"
gsettings get <settings-path> <settings-key>
```

To set the value of a setting, you can run the following command:

```bash title="Set settings value"
gsettings set <settings-path> <settings-key> <value>
```
