source ~/.config/fish/functions/_notify_window_info.fish
source ~/.config/fish/functions/_notify_send.fish

function notify
	set cmd $argv
	set my_window (hyprctl activewindow -j | jq -r '.address')
	eval $cmd
	set info (_notify_window_info $my_window)
	set workspace $info[1]
	set is_visible $info[2]
	if test $is_visible -eq 0
		_notify_send $workspace $cmd
	end
end
