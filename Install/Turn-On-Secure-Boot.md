# Turn on Secure Boot

!!! warning "Adjust Secure boot settings in your BIOS!"

    AnduinOS supports Secure boot well. During the installation, it is very recommended to turn on Secure Boot to ensure the security of your system. If you have already installed AnduinOS without Secure Boot, you can turn on Secure Boot at any time. However, you may need to sign the kernel modules manually if you have installed third-party kernel modules.

    ![Adjust secure boot settings](./seboot.png)

To turn on Secure Boot, you need to enter BIOS settings first. The key to enter BIOS settings varies depending on the manufacturer of your computer. Common keys include `F2`, `F10`, `Volume up + Power` or `Del`. You can usually see the key to enter BIOS settings on the boot screen when you start your computer.

Boot your computer, press `F2` or the key to enter BIOS settings, and then find the Secure Boot option in the BIOS settings. Enable Secure Boot and save the changes. Set the Secure Boot certificate to `Linux` or `3rd Party CA`. After that, you can boot your computer from the AnduinOS USB drive and install AnduinOS.

To verify that Secure Boot is enabled, you can boot AnduinOS on your computer and run the following command in the terminal:

```bash title="Check Secure Boot status"
$ sudo mokutil --sb-state
SecureBoot enabled
```

You should see `SecureBoot enabled` in the output, which means Secure Boot is enabled on your computer.
