# fzf

!!! tip "AnduinOS Verified App - Open Source"

    Fzf is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

fzf is a command-line fuzzy finder. [source code](https://github.com/junegunn/fzf)

It's an interactive filter program for any kind of list; files, command history, processes, hostnames, bookmarks, git commits, etc. It implements a "fuzzy" matching algorithm, so you can quickly type in patterns with omitted characters and still get the results you want.

Run this command to install fzf on AnduinOS:

```bash
sudo apt install fzf
```

Add the following line to `~/.bashrc`

```bash
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash
```

Next, open new terminal to get [three new key bindings](https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line), which are related to the functionality of fzf with bash.

| Keybind     | Function               |
| ----------- | ---------------------- |
| `Ctrl + R`  | Command History        |
| `Ctrl + T`  | Current Folder Files   |
| `Alt + c`   | cd Helper              |
