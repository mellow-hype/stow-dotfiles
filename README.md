# dotfiles managed w/ stow

```
git clone <this-repo> ~/.stow-dotfiles
```

## basic install of tty dotfiles (nvim, zshrc, tmux)

```
cd ~/.stow-dotfiles
stow -t $HOME tty-base/.
```

## sway desktop config files

Dependencies: `sway, i3status, dunst, fuzzel, foot, gammastep, kanshi, swaylock`

```sh
cd ~/.stow-dotfiles
stow -t $HOME sway-desktop/.
```

## scripts

```sh
# for tty-only scripts
cd ~/.stow-dotfiles/scripts
stow -t $HOME/bin tty-scripts

# for gui scripts
cd ~/.stow-dotfiles/scripts/desktop-scripts
stow -t $HOME/bin -S media sway util
```
