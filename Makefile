
ifdef SIM
  SIMARG := --simulate
else
  SIMARG :=
endif

.PHONY: tty tty_scripts

all:
	echo "sway_desktop|gui_scripts|tty_scripts|tty_configs"

tty:
	stow $(SIMARG) -v -t $(HOME) tty

sway_desktop:
	mkdir -p $(HOME)/.config/qutebrowser && \
		stow $(SIMARG) -v -t $(HOME) sway-desktop

tty_scripts:
	cd scripts && stow $(SIMARG) -v -t $(HOME)/bin tty-scripts

gui_scripts:
	cd scripts/desktop-scripts && stow $(SIMARG) -v -t $(HOME)/bin sway media util

install_colors:
	mkdir -p $(HOME)/.config/colors && \
	stow $(SIMARG) -v -t $(HOME)/.config/colors colors

