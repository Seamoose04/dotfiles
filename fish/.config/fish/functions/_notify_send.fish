function _notify_send
	set workspace $argv[1]
	set cmd $argv[2..]
	notify-send "Command Complete in Workspace $workspace" "$cmd"
end
