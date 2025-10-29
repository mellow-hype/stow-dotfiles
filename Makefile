STOWARGS := --dotfiles -v 

ifdef SIM
  STOWARGS += --simulate
endif

.PHONY: tty tty_scripts doom

all:
	echo "sway_desktop|gui_scripts|tty_scripts|tty_configs"

doom:
	stow $(STOWARGS) -t $(HOME)/.config/doom doom

tty:
	stow $(STOWARGS) -t $(HOME) tty

sway_desktop:
	mkdir -p $(HOME)/.config/qutebrowser && \
		stow $(STOWARGS) -t $(HOME) sway-desktop

tty_scripts:
	cd scripts && stow $(STOWARGS) -t $(HOME)/bin tty-scripts

gui_scripts:
	cd scripts/desktop-scripts && stow $(STOWARGS) -t $(HOME)/bin sway media util

install_colors:
	mkdir -p $(HOME)/.config/colors && \
	stow $(STOWARGS) -t $(HOME)/.config/colors colors

