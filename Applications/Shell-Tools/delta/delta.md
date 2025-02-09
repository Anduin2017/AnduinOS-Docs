# delta

delta is a syntax-highlighting pager for git, diff, grep, and blame output. [source code](https://github.com/dandavison/delta)

Run this command to install delta on AnduinOS.

```bash
sudo apt install git-delta
```

Run this command to use delta in git.

```bash
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
```

Checkout more usage in [docs](https://dandavison.github.io/delta/).
