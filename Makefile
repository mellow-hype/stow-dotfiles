
all:
	echo "sway_desktop|gui_scripts|tty_scripts|tty_configs"

tty:
	stow -v -t $(HOME) tty

sway_desktop:
	mkdir -p $(HOME)/.config/qutebrowser
	stow -v -t $(HOME) sway-desktop

tty_scripts:
	cd scripts && stow -v -t $(HOME)/bin tty-scripts

gui_scripts:
	cd scripts && stow -v -t $(HOME)/bin desktop-scripts

install_colors:
	mkdir -p $(HOME)/.config/colors
	stow -v -t $(HOME)/.config/colors colors

