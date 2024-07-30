# .NET

.NET is a free, cross-platform, open source developer platform for building many different types of applications.

To install .NET 8 on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install dotnet8
```

To install .NET 6 on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install dotnet6
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
