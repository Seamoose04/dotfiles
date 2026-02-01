#
# ~/.bashrc
#

eval "$(starship init bash)"
eval "$(fzf --bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="nvim"
export VISUAL="$EDITOR"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias logout='loginctl terminate-user $USER'
alias icat='kitten icat'

PS1='[\u@\h \W]\$ '

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"

# git ssh
eval "$(ssh-agent -s)"
