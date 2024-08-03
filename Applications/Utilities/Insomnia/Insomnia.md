# Insomnia

Insomnia is a powerful REST API client that allows you to design, debug, and test RESTful APIs. It is a cross-platform application that is available for Windows, macOS, and Linux. Insomnia is designed to make it easy to work with REST APIs and provides features such as code generation, authentication, and debugging tools.

To install Insomnia on AnduinOS, you can run:

```bash
wget https://updates.insomnia.rest/downloads/ubuntu/latest -O insomnia.deb
sudo dpkg -i insomnia.deb
rm insomnia.deb
```

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
