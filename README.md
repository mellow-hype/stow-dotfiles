# dotfiles w/ stow

## clone the repo

```
git clone --recursive <this-repo> ~/.stow-dotfiles
```

## install basic tty dotfiles (nvim, zshrc, tmux)

```sh
# install configs for common CLI tools: zsh, tmux, nvim, etc.
make tty

# install CLI-based scripts
make tty_scripts
```

## common GUI

Config files for common GUI applications

```sh
make desktop
make gui_scripts
```

## sway desktop profile

Dependencies: `sway, i3status, dunst, fuzzel, foot, gammastep, kanshi, swaylock`

```sh
make sway_desktop
make gui_scripts
```

