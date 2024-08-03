# Visual Studio Code

Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS. It includes support for debugging, embedded Git control, syntax highlighting, intelligent code completion, snippets, and code refactoring. It is also customizable, so users can change the editor's theme, keyboard shortcuts, and preferences.

To install Visual Studio Code on AnduinOS, you can run:

```bash title="Install Visual Studio Code"
cd ~
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code
```

## Set Visual Studio Code as the default text editor

After installing Visual Studio Code, you can set it as the default text editor by running:

```bash title="Set Visual Studio Code as the default text editor"
xdg-mime default code.desktop text/html
xdg-mime default code.desktop text/css
xdg-mime default code.desktop text/tsx
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop text/xml
xdg-mime default code.desktop text/x-csrc
xdg-mime default code.desktop text/x-csharp
xdg-mime default code.desktop text/x-c++src
xdg-mime default code.desktop text/x-c++hdr
xdg-mime default code.desktop text/x-python
xdg-mime default code.desktop text/x-java
xdg-mime default code.desktop text/x-ruby
xdg-mime default code.desktop text/x-php
xdg-mime default code.desktop text/x-shellscript
xdg-mime default code.desktop text/x-yaml
xdg-mime default code.desktop text/x-sql
xdg-mime default code.desktop text/x-dockerfile
xdg-mime default code.desktop text/x-nginx-conf
xdg-mime default code.desktop text/x-apacheconf
xdg-mime default code.desktop text/x-ini
xdg-mime default code.desktop text/x-toml
xdg-mime default code.desktop application/json
xdg-mime default code.desktop application/xml
xdg-mime default code.desktop application/javascript
xdg-mime default code.desktop application/typescript
xdg-mime default code.desktop application/x-shellscript
xdg-mime default code.desktop application/x-yaml
```

And when you open a file with the specified MIME type, it will be opened with Visual Studio Code by default.
