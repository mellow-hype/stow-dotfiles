STOW_ARGS := --dotfiles -v
HOSTNAME := $(hostnamectl hostname)

ifdef SIM
STOW_ARGS += --simulate
endif

all:
	echo "sway_desktop|gui_scripts|tty_scripts|tty_configs"

.PHONY: tty sway_desktop tty_scripts gui_scripts emacs

tty:
	stow $(STOW_ARGS) -t $(HOME) tty

emacs:
	stow $(STOW_ARGS) -t $(HOME) emacs

sway_desktop:
	mkdir -p $(HOME)/.config/qutebrowser && stow $(STOW_ARGS) -t $(HOME) sway-desktop

tty_scripts:
	cd scripts && stow $(STOW_ARGS) -t $(HOME)/bin tty-scripts

gui_scripts:
	cd scripts && stow $(STOW_ARGS) -t $(HOME)/bin -S util media sway

install_colors:
	mkdir -p $(HOME)/.config/colors && stow -v -t $(HOME)/.config/colors colors

