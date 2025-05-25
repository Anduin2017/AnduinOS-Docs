# Install Ubuntu Pro on AnduinOS

Ubuntu Pro is a subscription service that provides additional security and support for Ubuntu systems.

By default, AnduinOS disabled Ubuntu Pro, but you can enable it by following these steps.

Before starting, remove the flag files that prevent the upgrade of base packages:

```bash title="Remove Flag Files"
sudo rm /etc/apt/preferences.d/no-upgrade-base-files
sudo rm /etc/apt/preferences.d/no-upgrade-software-properties-gtk
```

Then, you can install Ubuntu Pro by running the following command:

```bash title="Install Ubuntu Pro"
sudo apt update
sudo apt reinstall lsb-release distro-info base-files software-properties-gtk ubuntu-pro-client
```

That's it! You have successfully installed Ubuntu Pro on AnduinOS.
You can verify the installation by checking the status of Ubuntu Pro:

```bash title="Check Ubuntu Pro Status"
ubuntu-pro status
```

If you want to enable the Ubuntu Pro features, you can run the following command:

```bash title="Enable Ubuntu Pro Features"
sudo ubuntu-pro attach --auto
```

For more information about Ubuntu Pro, you can visit the [Ubuntu Pro documentation](https://ubuntu.com/pro).
