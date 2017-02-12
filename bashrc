# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# vi key bindings
set -o vi

# ctrl+L clears the screen
bind -m vi-insert "\C-l":clear-screen

# prompt
PROMPT_COMMAND='hasjobs=$(jobs -p)'
export PS1='[$(date +%H%M) \u@\h \w]\
${hasjobs:+(\j)} \
\[\033[38;5;46m\]$\
\[$(tput sgr0)\] '

# exports
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PAGER="less"
export EDITOR="vim"
export VISUAL="$EDITOR"
export PATH="$HOME/bin:$PATH"

# history
HISTCONTROL=ignoreboth
HISTIGNORE="bg:fg:history"
HISTSIZE=10000
HISTFILESIZE=10000

# shopts
shopt -s checkwinsize
shopt -s histappend
shopt -s dotglob
shopt -s globstar
shopt -s direxpand

# flow control
stty -ixon

# aliases
alias ls="ls --color=auto -F"
alias ll="ls -lh"
alias la="ls -lah"
alias grep="grep --color=auto"

# bin path
PATH="$PATH:$HOME/bin"

# local configurations
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
