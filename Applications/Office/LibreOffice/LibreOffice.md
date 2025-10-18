# LibreOffice

!!! tip "AnduinOS Verified App - Open Source"

    LibreOffice is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

LibreOffice is a free and open-source office suite, a project of The Document Foundation. It was forked from OpenOffice.org in 2010, which was an open-sourced version of the earlier StarOffice. The LibreOffice suite comprises programs for word processing, creating and editing of spreadsheets, slideshows, diagrams and drawings, working with databases, and composing mathematical formulae. It is available in 110 languages.

## Flatpak install (Recommended)

You can install LibreOffice via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub org.libreoffice.LibreOffice
```

## System install

To install LibreOffice on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install libreoffice
```

However, that will install the LibreOffice suite, which includes multiple applications. If you only need a specific application, you can install it separately. Here are the available packages:

- `libreoffice-writer`: Word processor
- `libreoffice-calc`: Spreadsheet editor
- `libreoffice-impress`: Presentation program
- `libreoffice-draw`: Drawing program
- `libreoffice-math`: Equation editor
- `libreoffice-base`: Database management program
- `libreoffice-common`: Common files for LibreOffice
- `libreoffice-core`: Core functionality for LibreOffice
- `libreoffice-style-*`: Various styles for LibreOffice

For example, if you only want to install the word processor, you can run:

```bash
sudo apt update
sudo apt install libreoffice-writer
```
