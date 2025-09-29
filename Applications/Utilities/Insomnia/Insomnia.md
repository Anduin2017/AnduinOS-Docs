# Insomnia

Insomnia is a powerful REST API client that allows you to design, debug, and test RESTful APIs. It is a cross-platform application that is available for Windows, macOS, and Linux. Insomnia is designed to make it easy to work with REST APIs and provides features such as code generation, authentication, and debugging tools.

## Flatpak install (Recommended)

You can install Code::Blocks via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub rest.insomnia.Insomnia
```

## System install

To install Insomnia on AnduinOS, you can run:

```bash
curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' \
  | sudo -E distro=ubuntu codename=focal bash
sudo apt-get update
sudo apt-get install insomnia
```

!!! warning "This application is made for Focal and not adopted for Jammy"

    This application is only available for Ubuntu 20.04 (Focal Fossa). While on AnduinOS, you can install it, but it may not work as expected and cause package conflicts.

    We are still waiting for the official release of Insomnia for Jammy
