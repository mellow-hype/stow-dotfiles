# dotfiles w/ stow

TTY dotfiles for use in keyless/untrusted environments.

## What's included

- `.gitconfig` — git configuration
- `.tmux.conf` — tmux configuration
- `.zshrc` — ZSH configuration
- `dot-config/zsh-custom/` — ZSH themes
- `dot-config/nvim/init.lua` — minimal plugin-free Neovim config

## Install

```sh
git clone <this-repo> ~/.stow-dotfiles
cd ~/.stow-dotfiles
make tty
```

## Options

```sh
make tty SIM=1            # dry-run
make tty ACTION=restow    # prune stale symlinks and re-stow
make tty ACTION=delete    # remove symlinks
```
