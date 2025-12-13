STOW_ARGS := --dotfiles -v

ifdef SIM
STOW_ARGS += --simulate
endif

all:
	echo "targets: tty|sway_desktop|gui_scripts|tty_scripts"

.PHONY: tty sway_desktop tty_scripts gui_scripts emacs

tty:
	stow --no-folding $(STOW_ARGS) -t $(HOME) tty

sway_desktop:
	stow --no-folding $(STOW_ARGS) -t $(HOME) sway-desktop

tty_scripts:
	make -C scripts/ tty

gui_scripts:
	make -C scripts/ gui

install_colors:
	mkdir -p $(HOME)/.config/colors && stow $(STOW_ARGS) -t $(HOME)/.config/colors colors

emacs:
	stow  $(STOW_ARGS) -t $(HOME) emacs

