# gh

!!! tip "AnduinOS Verified App - Open Source"

    gh is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

gh is GitHub on the command line. It brings pull requests, issues, and other GitHub concepts to the terminal next to where you are already working with git and your code. [source code](https://github.com/cli/cli)

Run the following command to install gh on AnduinOS:

```bash
sudo apt install gh
```

Login your github account:

```bash
gh auth login
```

Create a remote repository from the current directory:

```bash
gh repo create my-project --private --source=. --remote=upstream
```

Checkout the github repository in browser:

```bash
gh repo view -w
```

Checkout [the official website](https://cli.github.com/) for more tips!

Also checkout [glab](../glab/glab.md) if you are using gitlab.
