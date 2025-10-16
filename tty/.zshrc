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
# ruby gems setup
export GEM_HOME=$HOME/gems

# ssh agent service socket
#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# if we're an ssh session, override TERM to something that should work everywhere
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
fi

# systemd unit state
_systemctl_unit_state() {
    typeset -gA _sys_unit_state
    _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
    zle && zle -R
}

# == vi-mode stuff
# allow vi-mode plugin to change the cursor
export VI_MODE_SET_CURSOR="true"
export KEYTIMEOUT=1

# set cursor and prompt to show current mode (insert/normal)
function vi_mode_cursor_set() {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      # static block cursor for normal mode
      echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
      # blinking beam cursor for normal mode
      echo -ne '\e[5 q'
    fi
}

# set prompt, mode indicator, and update cursor
function zle-keymap-select {
    VIM_NORMAL_PROMPT="%{$fg_bold[green]%} [% N]% %{$reset_color%}"
    VIM_INSERT_PROMPT="%{$fg_bold[magenta]%} [% I]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL_PROMPT}/(main|viins)/$VIM_INSERT_PROMPT} %D{%T}"
    vi_mode_cursor_set
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init  {
    zle -K viins  # start with insert mode keymap
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# HOOKS - run ahead of the prompt being generated (i.e. each time control returns to the terminal)
# ring a bell each time (god help you if you leave the bell sound on)
ring_bell_on_pre() { echo -n -e "\a" }
# rprompt_ts() { RPROMPT="%D{%T}" }
typeset -a precmd_functions
precmd_functions+=(ring_bell_on_pre)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
alias zshreload="omz reload"

# open config files
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# ls aliases
LSBIN=$(bash -c "which ls")
LS_BASE="$LSBIN --color=auto"
alias l="$LS_BASE"
alias ls="$LS_BASE -lh --group-directories-first"
alias sl="ls"
alias la="ls -Ah"

# git aliases
alias gpo="git push origin $(git_current_branch)"
alias gst="git status"
alias gcm="git commit -m"

# tmux
alias tml="tmux ls"
alias tma="tmux attach -t"
alias tmn="tmux new -s"

# import other aliases
ALIAS_FILE="$HOME/.config/aliases"
if [[ -e "$ALIAS_FILE" ]]; then
    source "$ALIAS_FILE"
fi
