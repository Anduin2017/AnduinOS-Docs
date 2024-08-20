# Turn on Secure Boot

!!! warning "Adjust Secure boot settings in your BIOS!"

    During the installation of AnduinOS, you need to [disable Secure Boot](./Install-AnduinOS-From-USB.md) in the BIOS settings to install AnduinOS. And you need to re-enable Secure Boot after the installation.

    ![Adjust secure boot settings](./seboot.png)

To turn on Secure Boot, you need to enter BIOS settings first. The key to enter BIOS settings varies depending on the manufacturer of your computer. Common keys include `F2`, `F10`, `Volume up + Power` or `Del`. You can usually see the key to enter BIOS settings on the boot screen when you start your computer.

Boot your computer, press `F2` or the key to enter BIOS settings, and then find the Secure Boot option in the BIOS settings. Disable Secure Boot and save the changes. Then you can boot your computer from the USB drive.

To verify that Secure Boot is enabled, you can boot AnduinOS on your computer and run the following command in the terminal:

```bash title="Check Secure Boot status"
$ sudo mokutil --sb-state
SecureBoot enabled
```

You should see `SecureBoot enabled` in the output, which means Secure Boot is enabled on your computer.
