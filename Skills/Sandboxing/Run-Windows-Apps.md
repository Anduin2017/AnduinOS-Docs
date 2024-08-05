# Run Windows Apps on Linux

To run Windows apps on Linux, you can use Wine, a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, and BSD. Wine is free and open-source software, and it is available for download on the WineHQ website.

## Install Wine

To install Wine on AnduinOS, run the following commands:

To install Wine with 64-bit support only:

```bash title="Install Wine"
sudo apt update
sudo apt install wine64
```

To install Wine with both 64-bit and 32-bit support (recommended):

```bash title="Install Wine"
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine64 wine32
```

## Setup Wine

After installing Wine, you can configure it by running the following command:

```bash title="Configure Wine"
winecfg
```

This command will open the Wine configuration window, where you can set up various options, such as Windows version compatibility, audio settings, and drive mappings.

## Run Windows Apps

To run a Windows app using Wine, you can use the following command:

```bash title="Run Windows App"
wine /path/to/windows-app.exe
```

Replace `/path/to/windows-app.exe` with the actual path to the Windows application executable file.
