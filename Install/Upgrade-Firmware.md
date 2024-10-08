# Upgrade firmware

`fwupd` is a daemon to allow session software to update device firmware on your local machine. It is designed to be vendor-agnostic as possible and to work with all devices.

To install `fwupd` on Ubuntu, run the following command:

```bash
sudo apt install fwupd
```

To refresh the firmware, run the following command:

```bash title="Refresh firmware"
sudo fwupdmgr refresh
```

To check the firmware information, run the following command:

```bash title="Check for updates"
sudo fwupdmgr get-updates
```

To upgrade the firmware, run the following command:

```bash title="Upgrade firmware"
sudo fwupdmgr update
```

For example, the following screenshot shows the firmware upgrade process on a Dell device:

![AnduinOS Upgrade Firmware](./fw.png)
