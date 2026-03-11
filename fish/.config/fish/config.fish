if status is-interactive
	# Editor
	set -x EDITOR nvim
	set -x VISUAL nvim
	set -gx PATH /opt/cuda/bin $PATH
	set -gx LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

	# Starship
	starship init fish | source

	# git ssh setup
	eval (ssh-agent -c)

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
