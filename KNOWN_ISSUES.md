# Known issues

## Gnome Desktop Manager can not start on Hyper-V Gen 1 VM

When you start AnduinOS on a Hyper-V Gen 1 VM, the Gnome Desktop Manager may not start. It may stuck at the boot screen. This is a known issue and can be reproduced on Ubuntu 22.04. The workaround is to use a Hyper-V Gen 2 VM.

## Users may not able to change the home page of the Firefox (Only affects 1.1 and 1.2)

When you start Firefox for the first time, it may not allow you to change the home page. This is a known issue and can be reproduced on 1.1 and 1.2.

We are fixing this issue from `1.1.4` and `1.2.4`. The workaround is to use the following command to reset the Firefox profile.

```bash title="Reset Firefox profile"
sudo rm /usr/lib/firefox/mozilla.cfg
```

## Users may keeps being prompted that `An application wants access to the keyring` (Only affects 1.3)

When you start AnduinOS, you may be prompted that `An application wants access to the keyring`. This is a known issue and can be reproduced on 1.3.

We are fixing this issue from `1.3.1`. The workaround is to install the `libpam-gnome-keyring` package.

```bash title="Install libpam-gnome-keyring"
sudo apt install libpam-gnome-keyring
```

And you need to reset the password of the keyring to be the same as your login password.

## NVIDIA driver may crash (Only affects 1.3)

When using the NVIDIA driver with Wayland, you may encounter a crash.

```log
[drm:nv_drm_atomic_commit [nvidia_drm]] *ERROR* [nvidia-drm] [GPU ID 0x00000100] Flip event timeout on head 0
```

This issue can only be fixed from NVIDIA driver side. The discussion is on [https://forums.developer.nvidia.com/t/bug-570-124-04-freeze-on-monitor-wakeup-flip-event-timeout/325659](https://forums.developer.nvidia.com/t/bug-570-124-04-freeze-on-monitor-wakeup-flip-event-timeout/325659).

To mitigate, it is recommended to use an older version of the NVIDIA driver. And use Xorg instead of Wayland.

To view available NVIDIA driver versions, you can use the following command:

```bash title="List available NVIDIA driver versions"
ubuntu-drivers list --gpgpu
```

And you may install the driver using the following command:

```bash title="Install NVIDIA driver"
sudo ubuntu-drivers install nvidia-driver-535-server
```

## The installer may stop responding (Only affects 1.2)

When the user clicks the `Install AnduinOS` app, the installer may stop responding. The workaround is to wait around 5 minutes. The installer will continue to run.

## After user logout, a pop up with message: "Authentication required" (Only affects 1.4)

This is because the `spice-vdagent` service is not running correctly. You can mitigate this via uninstalling the `spice-vdagent` package.

```bash title="Uninstall spice-vdagent"
sudo apt autoremove spice-vdagent
```

However this will disable the clipboard sharing feature between the host and the guest VM. We are still conducting investigation on this issue.

## The `OpenWeather Refined` extension may not work (Only affects 1.4)

The `OpenWeather Refined` extension may be able to show the weather information when user is clicking the icon. But it may not be able to show the weather information on the bar.
