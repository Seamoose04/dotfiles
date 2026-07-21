source ~/.config/fish/functions/_notify_window_info.fish
source ~/.config/fish/functions/_notify_send.fish

function _notify_watch
	set pid $argv[1]
	set cmd $argv[2..]
	set win_addr (hyprctl clients -j | jq -r --argjson pid $pid '.[] | select(.pid == $pid) | .address')

	while kill -0 $pid 2>/dev/null
		sleep 0.5
	end

	if test -n "$win_addr"
		set info (_notify_window_info $win_addr)
		set workspace $info[1]
		set is_visible $info[2]
		if test $is_visible -eq 0
			_notify_send $workspace $cmd
		end
	else
		_notify_send "?" $cmd
	end
end

function notify_attach
	set pid $argv[1]
	set cmd (cat /proc/$pid/cmdline | tr '\0' ' ')
	_notify_watch $pid $cmd &
	disown
end

