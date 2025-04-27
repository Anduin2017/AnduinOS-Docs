# Slack

Slack is a messaging app for teams. It brings all your team's communication and files in one place, where they're instantly searchable and available wherever you go.

To install Slack on AnduinOS, you can run the following commands in the terminal:

<!-- The link needs to be updated regularly. -->

```bash
link="https://downloads.slack-edge.com/desktop-releases/linux/x64/4.41.105/slack-desktop-4.41.105-amd64.deb"
wget $link -O slack.deb
sudo apt install ./slack.deb -y
rm slack.deb
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://slack.com/downloads/linux) to get the latest link.

!!! warning "Unable to automatically upgrade this application"

    The above command only installs the launcher. If you run `sudo apt upgrade`, it won't upgrade it automatically. You will need to manually rerun the above command to upgrade.

    This is because the software provider didn't setup a repository for automatic updates. You will need to check the official website for updates.
