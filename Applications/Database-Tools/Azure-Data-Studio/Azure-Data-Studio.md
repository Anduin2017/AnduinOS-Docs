# Azure Data Studio

Azure Data Studio is a cross-platform database tool for data professionals using the Microsoft family of on-premises and cloud data platforms on Windows, macOS, and Linux. To learn more about Azure Data Studio, visit the [Azure Data Studio documentation](https://docs.microsoft.com/sql/azure-data-studio/).

To install Azure Data Studio on AnduinOS, run the following commands.

```bash
url=https://go.microsoft.com/fwlink/?linkid=2275602
curl -fsSL $url -o azure-data-studio.deb
sudo dpkg -i azure-data-studio.deb
rm azure-data-studio.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
