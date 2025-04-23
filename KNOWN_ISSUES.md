# Known issues

## 1. Issue 1 - Gnome Desktop Manager can not start on Hyper-V Gen 1 VM

When you start AnduinOS on a Hyper-V Gen 1 VM, the Gnome Desktop Manager may not start. It may stuck at the boot screen. This is a known issue and can be reproduced on Ubuntu 22.04. The workaround is to use a Hyper-V Gen 2 VM.

## 2. Issue 2 - NVIDIA driver may crash

When using the NVIDIA driver with Wayland, you may encounter a crash.

```log
[drm:nv_drm_atomic_commit [nvidia_drm]] *ERROR* [nvidia-drm] [GPU ID 0x00000100] Flip event timeout on head 0
```

This issue can only be fixed from NVIDIA driver side. The discussion is on [https://forums.developer.nvidia.com/t/bug-570-124-04-freeze-on-monitor-wakeup-flip-event-timeout/325659](https://forums.developer.nvidia.com/t/bug-570-124-04-freeze-on-monitor-wakeup-flip-event-timeout/325659).