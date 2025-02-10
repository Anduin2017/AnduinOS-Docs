# zoxide

!!! tip "AnduinOS Verified App - Open Source"

    Zoxide is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

zoxide is a smarter cd command. Supports all major shells.  [source code](https://github.com/ajeetdsouza/zoxide)

It remembers which directories you use most frequently, so you can "jump" to them in just a few keystrokes.

Install zoxide to AnduinOS:

```bash
sudo apt install zoxide
```

Activate zoxide in your shell:

```bash
# add this line to your $HOME/.bashrc if you are using bash
eval "$(zoxide init bash)"

# add this line to your $HOME/.zshrc if you are using zsh
eval "$(zoxide init zsh)"
```

Then you can use `z` to change directories.

If you want to use `cd` as an alias to `z`, don't add alias, cause this will cause some issue. Just add a flag on zoxide init script like bellow:

```bash
eval "$(zoxide init zsh --cmd cd)"
```
