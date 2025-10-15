# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/gems/bin:$HOME/.npm-global/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Custom ZSH customization dir
ZSH_CUSTOM=$HOME/.config/zsh-custom

# Set name of the theme to load
ZSH_THEME="hyper-minimal"

# load plugins
plugins=(gitfast rsync vi-mode)

# load ohmyzsh
source $ZSH/oh-my-zsh.sh

# set editor
export EDITOR='vim'

# if we're an ssh session, override TERM to something that should work everywhere
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

_systemctl_unit_state() {
    typeset -gA _sys_unit_state
    _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# HOOKS - runs ahead of the prompt being generated (i.e. each time control returns to the terminal)
# ring a bell each time (god help you if you leave the bell sound on)
ring_bell_on_pre() { echo -n -e "\a" }
# set a timestamp as an RPROMPT
rprompt_ts() { RPROMPT="%D{%T}" }
typeset -a precmd_functions
precmd_functions+=(rprompt_ts ring_bell_on_pre)

# ruby gems setup
export GEM_HOME=$HOME/gems

# ssh agent service socket
#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
alias zshreload="omz reload"

# open config files
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# better default ls and variants
LSBIN=$(bash -c "which ls")
alias l="$LSBIN --color=auto"
alias ls="$LSBIN -lh --color=auto --group-directories-first"
alias la="ls -A"
alias sl="ls"

# git aliases
alias gpo="git push origin $(git_current_branch)"
alias gstat="git status"

# command wrappers
alias vim="nvim"
alias cat="bat"
# alias bat="batcat"
alias apti="sudo apt install"
alias dl="wget"
alias ff="fzf"
alias c="clear"
alias mkx="chmod +x"
alias rmf="rm -rf"
alias cpa="cp -a"

# fzf history find
alias fzh="history | sort -r -g | fzf --scheme=history --accept-nth 2.."

# Nix wrappers
alias nxr="sudo nixos-rebuild"
alias nxsh="nix-shell"

# media
alias yv="mpv --cache-pause-initial=yes --ytdl-format='bestvideo[height<=720]+bestaudio/best'"
alias ya="mpv --ytdl-format='bestaudio/best'"

# tmux aliases
alias tml="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -s"

# check listening ports
alias lptun="sudo ss -lptun"

# alias for managing tty-dotfiles git repo
alias cfg='git --git-dir=$HOME/.tty-dotfiles/ --work-tree=$HOME'
alias cfga='cfg add'
alias cfgs='cfg status'
alias cfgc='cfg commit -m'
alias cfgl='cfg log'

# vim stuff
alias vpy="echo -e '#!/usr/bin/env python3' | vim - +'file tmp.py'"
alias vsh="echo -e '#!/usr/bin/env bash' | vim - +'file tmp.sh'"

# other helper/utility aliases
alias uart="sudo screen /dev/ttyUSB0 115200"
alias ddiso="sudo dd bs=4M conv=fsync oflag=direct status=progress"
