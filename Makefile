STOW_ARGS := --dotfiles -v

ifdef SIM
STOW_ARGS += --simulate
endif

# ACTION=restow (-R) or ACTION=delete (-D)
ifdef ACTION
ifeq ($(ACTION),restow)
STOW_ARGS += -R
else ifeq ($(ACTION),delete)
STOW_ARGS += -D
else
$(error unknown ACTION '$(ACTION)' (expected: restow, delete))
endif
endif

.DEFAULT_GOAL := help

.PHONY: help tty

help:
	@echo "stow-dotfiles — public TTY configs"
	@echo ""
	@echo "NOTE: Desktop, emacs, color themes, and scripts have been"
	@echo "migrated to the private priv-configs repository."
	@echo ""
	@echo "Targets:"
	@echo "  tty     deploy .gitconfig, .tmux.conf, .zshrc, zsh-custom, minimal nvim"
	@echo ""
	@echo "Options:"
	@echo "  ACTION=restow   prune stale symlinks and re-stow"
	@echo "  ACTION=delete   remove symlinks"
	@echo "  SIM=1           dry-run (simulate)"

tty:
	stow --no-folding $(STOW_ARGS) -t $(HOME) tty
