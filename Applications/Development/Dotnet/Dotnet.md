# .NET

!!! tip "AnduinOS Verified App - Open Source"

    .NET is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

.NET is a free, cross-platform, open source developer platform for building many different types of applications.

First. Add the .NET backports repository (if applicable).

```bash
if [[ "$(lsb_release -sc)" =~ ^(devel|jammy|noble)$ ]]; then
  sudo add-apt-repository ppa:dotnet/backports
fi
```

To install .NET 9 on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install dotnet9
```

To install .NET 8 on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install dotnet8
```

That's it. You can now start using .NET on AnduinOS.

```bash
mkdir myapp
cd myapp
dotnet new console
dotnet run
```

## .NET Global tools

You may need to install some global tools to help you with your development. You can install them using the following command:

```bash
# Dotnet tools
function TryInstallDotnetTool {
  toolName=$1
  globalTools=$(dotnet tool list --global)

  if [[ $globalTools =~ $toolName ]]; then
    echo "$toolName is already installed. Updating it.." 
    dotnet tool update --global $toolName --interactive
  else
    echo "$toolName is not installed. Installing it.."
    if ! dotnet tool install --global $toolName --interactive ; then
      echo "$toolName failed to be installed. Trying updating it.."
      dotnet tool update --global $toolName --interactive
    fi
  fi
}

TryInstallDotnetTool "dotnet-ef"
TryInstallDotnetTool "Aiursoft.Static"
```
