# PowerShell

PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. Initially a Windows component only, known as Windows PowerShell, it was made open-source and cross-platform on 18 August 2016 with the introduction of PowerShell Core. The former is built on the .NET Framework, the latter on .NET Core.

To install PowerShell on AnduinOS, you can run:

```bash
cd ~
wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
sudo apt install ./packages-microsoft-prod.deb
rm ./packages-microsoft-prod.deb
sudo apt update
sudo apt install powershell

# We MUST remove this file because it will mess up the `dotnet*` installation.
sudo rm /etc/apt/sources.list.d/microsoft-prod.list
sudo apt update
```

Then you can run PowerShell by typing `pwsh` in the terminal.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.

!!! warning "PowerShell depends on libicu which may not be available in the default repositories"

    PowerShell depends on `libicu` which is not available in the default repositories. You will need to override it manually.

    For example, you may have `libicu76` installed, but PowerShell requires `libicu70`. You can fix it by overriding the dependency with the following 

    First, download the `PowerShell` deb package.

    Then, install the `libicu76` package:

    ```bash
    sudo apt install libicu76
    ```

    Now, you can edit the dependency of the `PowerShell` deb package.

    ```bash
    mkdir -p pwsh-extract
    dpkg-deb -R ms-powershell.deb pwsh-extract/
    vim pwsh-extract/DEBIAN/control
    ```

    Edit the `Depends` line to remove `libicu70` and add `libicu76`:

    ```text
    Depends: libicu76
    ```

    Then, you can repackage the deb file:

    ```bash
    dpkg-deb -b pwsh-extract/ modified-pwsh.deb
    ```

    Finally, install the modified deb package:

    ```bash
    sudo dpkg -i modified-pwsh.deb
    ```

    This will install PowerShell with the modified dependency.