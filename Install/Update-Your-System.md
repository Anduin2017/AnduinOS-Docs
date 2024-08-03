# Update your system

After AnduinOS is installed, it is essential to keep your system up-to-date to ensure that you have the latest security patches, bug fixes, and new features. This guide will show you how to update your system using the command line.

To update your system, you need to run:

```bash title="Update your system"
sudo apt update
sudo apt upgrade
```

That's it! We recommend you to run those commands regularly to keep your system up-to-date.

??? Tip "Should those commands be run automatically?"

    Automatic updates can save time and ensure you get security updates as soon as possible. They keep your packages clean and new, reducing the pain of large, infrequent upgrades. Historically, running `apt upgrade` has been very safe, with few reported issues. Additionally, automatic updates are common in other operating systems like Microsoft Windows.

    However, automatic updates are not recommended for most Linux users due to several reasons:

    - **Investigation**: Auto-updates can mask real problems, making it difficult to reproduce issues and their dependency trees during troubleshooting.
    - **AirGap Stability**: Some systems require extreme stability and cannot tolerate changes, such as flight control systems.
    - **Upgrade Risks**: New versions may introduce bugs or breaking changes, causing business interruptions.
    - **Rebooting Issues**: Updates often require reboots, which can be problematic for systems that have difficulty restarting or need to maintain synchronized caches.

    Automatic updates are advisable only if:

    - The system can tolerate availability degradation.
    - The system is stateless and rebooting won't affect its operation.
    - The system has a perfect backup or snapshot configuration.
    - The system is always connected to the Internet.
    - The system needs the latest functional updates.

    Consider these factors carefully before enabling automatic updates.

!!! info "How to enable automatic updates?"

    If you want to enable automatic updates, you can use the following script to set up unattended upgrades on your system.

    ```bash title="Setup automatic updates"
    echo "
    sudo apt update
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
    sudo apt --purge autoremove -y" | sudo tee /usr/local/bin/update.sh
    sudo chmod +x /usr/local/bin/update.sh
    (crontab -l ; echo "0 2 * * 0 /usr/local/bin/update.sh") | crontab -
    ```
