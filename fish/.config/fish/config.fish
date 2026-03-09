if status is-interactive
	# Editor
	set -x EDITOR nvim
	set -x VISUAL nvim

	# Starship
	starship init fish | source

	# fzf
	fzf --fish | source

	# Color aliases
	alias ls="ls --color=auto"
	alias grep="grep --color=auto"

	# Other aliases
	alias logout="loginctl terminate-user $USER"
	alias icat="kitten icat"
	alias refish="source ~/.config/fish/config.fish"

	# Kitty ssh fix
	if test "$TERM" = "xterm-kitty"
		alias ssh="TERM=xterm-256color command ssh"
	end
end
