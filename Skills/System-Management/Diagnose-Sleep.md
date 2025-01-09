# Diagnose Sleep on Linux

This document helps you diagnose and debug sleep (suspend/hibernate) issues on AnduinOS (or any Linux distribution). It covers the difference between **S0ix** (Modern Standby) and **S3** (Suspend to RAM), shows how to check which sleep states your system supports, and outlines steps to troubleshoot sleep failures or unexpected behaviors.

---

## 1. Understanding S0ix and S3

Modern computers implement different sleep states, the most common being **S0ix** (aka **Modern Standby**) and **S3** (traditional **Suspend to RAM**).

- **S0ix (S0 Idle Substates)**:
  - A low-power idle state within the normal S0 (working) power state.
  - Allows quick wake-up, often used in newer laptops.
  - Sometimes referred to as **S0i3** or **Modern Standby** on Windows.  
  - On Linux, it often appears as **`s2idle`** (though `s2idle` can also be a purely software-based suspend if hardware support is incomplete).

- **S3 (Suspend to RAM)**:
  - A deeper, traditional sleep state on most desktops and many laptops.
  - RAM remains powered, but most other hardware is switched off.
  - Wake-up is slightly slower than S0ix (though still pretty fast), but **power consumption is typically lower** than a pure S0ix platform.

### Why does it matter?

- **Power consumption**:  
  S3 tends to reduce power usage more effectively, particularly on desktops.  
  S0ix can be very efficient on well-supported hardware (e.g., certain ultrabooks) but can also be quite leaky if the firmware or drivers aren’t optimized.
- **Wake-up time**:  
  S0ix can resume almost instantly on hardware that fully supports it.  
  S3 also resumes quickly, but not as instant as S0ix.

---

## 2. Checking for S0ix Support

### 2.1 Querying ACPI Tables

Your system firmware (BIOS/UEFI) advertises which ACPI sleep states it supports. You can extract and inspect your ACPI tables with `acpidump` and `iasl`:

```bash
#!/bin/bash

sudo apt install acpica-tools -y

temp=$(mktemp -d)
cd "$temp"
sudo acpidump -b
iasl -d *.dat 2> /dev/null

# This line searches for "Low Power S0 Idle" within FACP (Fixed ACPI Description Table)
lp=$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print $(NF)}')

if [ "$lp" -eq 1 ]; then
    echo "Low Power S0 Idle is" "$lp"
    echo "The system supports S0ix!"
else
    echo "Low Power S0 Idle is" "$lp"
    echo "The system does not support S0ix!"
fi
```

- If the script shows:  
  **"The system supports S0ix!"**  
  Your firmware’s FACP table indicates S0ix is advertised.
- Otherwise, you likely only have traditional S3/S4/S5 states.

> **Note**: Even if “Low Power S0 Idle” is set to `1`, actual behavior can vary depending on kernel version and driver/firmware interactions. Sometimes hardware or firmware bugs may prevent real S0i3 usage.

---

## 3. Checking Available Sleep States in Linux

Linux exposes supported sleep states via the `/sys/power/state` file:

```bash
cat /sys/power/state
```

This might show a subset of:

- **`freeze`** (aka Suspend-to-idle, a lightweight software-driven suspend)
- **`standby`** (ACPI S1 on some architectures)
- **`mem`** (ACPI S3 or S0ix, depending on hardware/firmware)
- **`disk`** (ACPI S4, hibernation)

### 3.1 `mem` and `/sys/power/mem_sleep`

When you see `mem` in `/sys/power/state`, the underlying behavior can be **S3** or **S0ix** (or `s2idle`) depending on your hardware. To see which variant of `mem` your system is using by default, check:

```bash title="Check default suspend state"
cat /sys/power/mem_sleep
```

You’ll typically see two modes here:

- **`s2idle`**: A shallow, mostly software-based suspend. If your hardware truly supports S0i3, the kernel may place the CPU into deeper idle states while in `s2idle`. Otherwise, it’s just a light suspend mode.  
- **`deep`**: Traditional ACPI S3 deep suspend.

The output might be:

```text
[s2idle] deep
```

This means **`s2idle`** is the *current default*, but **`deep`** (S3) is also available.

Or:

```text
s2idle [deep]
```

Now **`deep`** (S3) is the default.

> **Tip**: You can switch between them by writing either `s2idle` or `deep` to `/sys/power/mem_sleep`, if your hardware and firmware actually support both:

```bash title="Switch sleep state"
echo s2idle | sudo tee /sys/power/mem_sleep
echo deep | sudo tee /sys/power/mem_sleep
```

---

## 4. Forcing a Sleep Immediately

If you want to manually test sleep, you can use:

```bash title="Force a suspend"
sudo systemctl unmask suspend.target
sudo systemctl suspend
```

This triggers a **Suspend to `mem`** (whichever variant is the current default).

To confirm it worked, check the kernel logs after resuming:

```bash title="Check kernel logs ACPI and power management messages"
sudo dmesg | grep -i -E 'acpi|pm'
```

You may see lines such as:

```text
[  831.097590] ACPI: EC: interrupt blocked
[  831.097591] ACPI: EC: interrupt blocked
[  831.140449] ACPI: PM: Preparing to enter system sleep state S3
[  831.344293] ACPI: EC: event blocked
[  831.344298] ACPI: EC: EC stopped
[  831.344299] ACPI: PM: Saving platform NVS memory
[  831.480552] ACPI: PM: Low-level resume complete
[  831.480632] ACPI: EC: EC started
[  831.480632] ACPI: PM: Restoring platform NVS memory
[  831.648210] ACPI: PM: Waking up from system sleep state S3
[  831.673580] ACPI: EC: interrupt unblocked
[  831.695092] ACPI: EC: event unblocked
```

This clearly indicates that your system actually used **S3** (deep).

If it were S2idle, you might see references to a mention of `s2idle` in the logs. For example:

```text
[14262.195856] PM: suspend entry (s2idle)
[14263.467432] ACPI: EC: interrupt blocked
[14270.703817] ACPI: EC: interrupt unblocked
[14271.069936] PM: suspend exit
```

Indicating that the system used **s2idle**.

!!! note "Is `s2idle` actually `S0ix`?"

    The kernel may use `s2idle` as a placeholder for S0ix if the hardware supports it. However, if the firmware or drivers don’t fully implement S0ix, it may just be a shallow suspend. To confirm, you’d need to check the ACPI tables and possibly the kernel source code.

---

## 5. What if It Only Shows S2idle?

> **S2idle** is a generic, software-driven, lightweight suspend variant. It freezes user space, suspends timekeeping, and puts I/O devices into low-power states so that the CPU can remain in deeper idle states while the system is “suspended.”

- If your firmware truly supports S0ix, Linux may attempt to leverage that in `s2idle`. However, on many platforms, it just becomes a **light software-only** suspend, which may cause higher power drain than expected.
- Some systems (especially certain modern ultrabooks) have intentionally disabled S3 in favor of S0ix. If you do not see `deep` as an option in `/sys/power/mem_sleep`, that usually means S3 is not exposed by BIOS/UEFI.

For more details, refer to the [official kernel documentation on system sleep states](https://docs.kernel.org/admin-guide/pm/sleep-states.html).

---

## 6. Checking for Wake-Up Sources

If your system wakes up immediately or sporadically, you may have certain devices set as wake sources. To list them:

```bash title="List wake-up sources"
cat /proc/acpi/wakeup
```

You’ll see output like:

```text
Device  S-state   Status   Sysfs node
PEG1      S4    *enabled  pci:0000:00:01.0
PEGP      S4    *disabled pci:0000:01:00.0
PEG2      S4    *disabled
PEG0      S4    *enabled  pci:0000:00:06.0
...
```

- **`S-state`**: which sleep state the device can wake from (S4, S3, etc.).
- **`Status`**: indicates if it’s currently enabled or disabled for wake-up.

You can toggle them by echoing into the file. For example, to disable a wake source:

```bash title="Disable a wake source"
echo PEG1 > /proc/acpi/wakeup
```

Repeat the command to re-enable it. This is helpful if your system keeps waking up due to e.g. USB devices, network cards, or other peripherals.

---

## 7. Additional Troubleshooting Tips

1. **BIOS/UEFI Settings**  
   - Some BIOS/UEFI firmwares allow you to toggle between S3 and Modern Standby. Check your firmware settings for an option like “Sleep Mode,” “Modern Standby,” or “Deep Sleep.”  
   - Ensure any relevant settings, such as “USB Wake Support,” “Wake on LAN,” or “Wake on Keyboard,” are configured appropriately.

2. **Kernel Parameters**  
   - You can force a default suspend variant via `mem_sleep_default=s2idle` or `mem_sleep_default=deep` in your boot loader (GRUB).  
   - For example, edit `/etc/default/grub`:

     ```bash title="Edit GRUB configuration"
     GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mem_sleep_default=deep"
     sudo update-grub
     ```

   - Reboot to apply. If your hardware does *not* actually support deep, the kernel will likely fall back to s2idle anyway.

3. **Driver or Firmware Issues**  
   - Ensure you have the latest firmware/BIOS.  
   - Check for known driver bugs in your Linux distribution’s bug tracker or on the kernel mailing lists.

4. **Power Analysis Tools**  
   - **powertop**: can help identify processes preventing deeper C-states.  
   - **tuned** or **cpupower**: can optimize CPU frequency scaling.  
   - **lspci -vv**: see if devices are stuck in full-power mode.

5. **Logs & ACPI Debugging**  
   - `dmesg`, `journalctl -b`, or `sudo journalctl -u systemd-suspend.service` can show if errors occurred during suspend or resume.  
   - For advanced debugging, you can enable kernel ACPI debug logs, but that usually requires building a custom kernel or adjusting log verbosity.

---

## 8. Summary

- **S0ix (Modern Standby)** and **S3 (Suspend to RAM)** differ in how they manage power.  
- Use ACPI tools (e.g., `acpidump`) to see if your hardware advertises S0ix.  
- `/sys/power/state` and `/sys/power/mem_sleep` indicate which sleep states are actually exposed and which one is the current default.  
- System logs (`dmesg`) confirm whether the system used S3, S2idle, or something else.  
- If your computer keeps waking up or fails to enter deep sleep, check wake-up sources and firmware settings.

By following the steps in this guide, you can pinpoint why your system chooses a particular sleep state and how to optimize or troubleshoot it. If you still experience unexpected behavior, consult your distribution’s forums or the kernel documentation for deeper debugging methods.

## 9. FAQ

**Q: Can I use S0ix on my desktop?**

A: S0ix is primarily designed for laptops and ultrabooks. Desktops usually rely on S3 for sleep, as they don’t need to maintain network connections or wake up as quickly as laptops.

**Q: Why does my laptop wake up immediately after suspending?**

A: This can be due to wake-up sources like USB devices, network cards, or firmware settings. Check `/proc/acpi/wakeup` to see which devices are enabled for wake-up.

**Q: How do I know if my system supports S0ix?**

A: Check the `Low Power S0 Idle` field in the FACP table of your ACPI tables. If it’s set to `1`, your system likely supports S0ix.

**Q: Can I force my system to use S3 instead of S0ix?**

A: You can try setting `mem_sleep_default=deep` in your boot loader configuration. However, if your hardware doesn’t support S3, the kernel will likely fall back to S0ix or s2idle.

**Q: Why does my system only show `s2idle` in `/sys/power/mem_sleep`?**

A: Some modern laptops have disabled S3 in favor of S0ix. If you don’t see `deep` as an option, that usually means S3 is not exposed by your firmware.

**Q: Why my computer failed to boot but with message below?**

```text
Free initramfs and sswitch to another root fss:
chroot to NEW_ROOTT. delete all in /, move NEW_ROOT to /.
execute NEW_INIT. PID must be 1. NEW_ROOT musst be a mountpoint.

-c DEV Reopen sstdio to DEV after switch
-d CAPS Drop capabilities
-n Dry run

No init found. Try passing init= bootarg.
```

A: This is a common error message when the system fails to find the initramfs or the init process. If this happend after you call `sudo systemctl hibernate`, it might because you didn't have swap partition or swap file. You can create a swap file by following the [official documentation](https://help.ubuntu.com/community/SwapFaq). Or simply disable hibernate by running `sudo systemctl mask hibernate.target`.
