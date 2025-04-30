# Known issues

## 1. Issue 1 - Gnome Desktop Manager can not start on Hyper-V Gen 1 VM

When you start AnduinOS on a Hyper-V Gen 1 VM, the Gnome Desktop Manager may not start. It may stuck at the boot screen. This is a known issue and can be reproduced on Ubuntu 22.04. The workaround is to use a Hyper-V Gen 2 VM.

## 2. Issue 2 - NVIDIA driver may crash (Only affects 1.3)

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

## 3. Issue 3 - The installer may stop responding (Only affects 1.2)

When the user clicks the `Install AnduinOS` app, the installer may stop responding. The workaround is to wait around 5 minutes. The installer will continue to run.
