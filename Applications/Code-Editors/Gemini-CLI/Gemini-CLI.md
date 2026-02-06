# Gemini CLI

!!! tip "AnduinOS Verified App - Open Source"

    [Gemini CLI](https://github.com/google-gemini/gemini-cli) is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Gemini CLI is a command-line interface tool for interacting with Google's Gemini AI models. It is an open-source AI agent that brings the power of Gemini directly into your terminal.

To install Gemini CLI on AnduinOS, you can run:

```bash
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg --yes
NODE_MAJOR=24
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs
sudo npm install -g @google/gemini-cli
```

The script above installs Node.js (with npm) as a prerequisite for Gemini CLI. If you already have Node.js installed, you can skip the Node.js installation part.

That's it! You now have Gemini CLI installed on your AnduinOS system. You can start using it by running the `gemini` command in your terminal.
