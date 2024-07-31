# PowerShell

PowerShell is a task automation and configuration management framework from Microsoft, consisting of a command-line shell and associated scripting language. Initially a Windows component only, known as Windows PowerShell, it was made open-source and cross-platform on 18 August 2016 with the introduction of PowerShell Core. The former is built on the .NET Framework, the latter on .NET Core.

To install PowerShell on AnduinOS, you can run:

```bash
wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb"
sudo dpkg -i ./packages-microsoft-prod.deb
rm ./packages-microsoft-prod.deb
sudo apt update
sudo apt install powershell

# We MUST remove this file because it will mess up the `dotnet*` installation.
sudo rm /etc/apt/sources.list.d/microsoft-prod.list
sudo apt update
```

Then you can run PowerShell by typing `pwsh` in the terminal.

However, after installing, `apt upgrade` won't update PowerShell automatically.

To update PowerShell, you can run:

```bash
wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb"
sudo dpkg -i ./packages-microsoft-prod.deb
rm ./packages-microsoft-prod.deb
sudo apt update
sudo apt upgrade powershell

# We MUST remove this file because it will mess up the `dotnet*` installation.
sudo rm /etc/apt/sources.list.d/microsoft-prod.list
sudo apt update
```
