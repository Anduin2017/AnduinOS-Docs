# Slack

Slack is a messaging app for teams. It brings all your team's communication and files in one place, where they're instantly searchable and available wherever you go.

To install Slack on AnduinOS, you can run the following commands in the terminal:

```bash
link="https://downloads.slack-edge.com/desktop-releases/linux/x64/4.39.95/slack-desktop-4.39.95-amd64.deb"
wget $link -O slack.deb
sudo dpkg -i slack.deb
sudo apt install --fix-broken -y
rm slack.deb
```
