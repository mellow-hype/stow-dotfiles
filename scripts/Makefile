STOW_ARGS := --dotfiles -v

ifdef SIM
STOW_ARGS += --simulate
endif

.PHONY: tty_scripts gui_scripts

tty:
	stow $(STOW_ARGS) -t $(HOME)/bin tty-scripts

restow_tty:
	stow $(STOW_ARGS) -t $(HOME)/bin -R tty-scripts

gui:
	stow $(STOW_ARGS) -d desktop-scripts -t $(HOME)/bin -S util media sway

restow_gui:
	stow $(STOW_ARGS) -d desktop-scripts -t $(HOME)/bin -R util media sway

