STOW_ARGS := --dotfiles -v

ifdef SIM
STOW_ARGS += --simulate
endif

.PHONY: bin common sway

bin:
	stow --no-folding $(STOW_ARGS) -t $(HOME)/bin bin

common:
	stow --no-folding $(STOW_ARGS) -t $(HOME)/.config common

sway: common bin
	stow --no-folding $(STOW_ARGS) -t $(HOME)/.config sway
