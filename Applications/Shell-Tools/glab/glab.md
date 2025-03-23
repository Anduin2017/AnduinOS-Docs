# glab

!!! tip "AnduinOS Verified App - Open Source"

    GLab is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

GLab is an open source GitLab CLI tool. It brings GitLab to your terminal, next to where you are already working with git and your code, without switching between windows and browser tabs. [source code](https://gitlab.com/gitlab-org/cli)

Run the following command to install glab on AnduinOS:

```bash
sudo apt install glab
```

Login your github account:

```bash
glab auth login
```

Create a private gitlab repository:

```bash
glab repo create my-project --private --defaultBranch master
```

Checkout the gitlab repository in browser:

```bash
glab repo view -w
```

Checkout [the official repository](https://gitlab.com/gitlab-org/cli) for more tips!

Also checkout [gh](../gh/gh.md) if you are using github.
