# Morden Shell

## ls replacement

### lsd

lsd is the next gen ls command. [source code](https://github.com/lsd-rs/lsd)

You must have [Nerd Fonts](https://www.nerdfonts.com/) installed to ues lsd perfectly. Don't worry, the nerd fonts has already installed in AnduinOS by default.

Install lsd to AnduinOS:

```bash
sudo apt install lsd
```

Then you can set an alias to replace ls:

```bash
# write this line to your .bashrc or .zshrc etc
alias ls=lsd
```

### eza

eza is a modern alternative to ls. [source code](https://github.com/eza-community/eza)

<!-- If you are still using exa, replace to eza bacause exa is nologger supported. -->

Install eza to AnduinOS:

```bash
sudo apt install eza
```

Then you can set an alias to replace ls:

```bash
alias ls=eza
```

## cd replacement

### zoxide

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
