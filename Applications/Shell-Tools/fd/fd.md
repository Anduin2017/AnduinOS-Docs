# fd

!!! tip "AnduinOS Verified App - Open Source"

    Fd is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

fd is a simple, fast and user-friendly alternative to `find`. [source code](https://github.com/sharkdp/fd)

`fd` is very easy to use and most importantly, super fast to find your file!

Run this command to install fd on AnduinOS:

```bash
sudo apt install fd-find
```

Then you can set a alias to fd:

```bash
# add this line to your .bashrc or .zshrc
alias fd=fdfind
```

Try to find your file:

```bash
fd main.c
```
