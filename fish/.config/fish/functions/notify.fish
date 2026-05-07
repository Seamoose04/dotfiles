function notify
	set cmd $argv
	set my_window (hyprctl activewindow -j | jq -r '.address')

	eval $cmd
	set code $status

	# Get all currently visible workspace IDs (one per monitor)
	set visible_workspaces (hyprctl monitors -j | jq -r '.[].activeWorkspaces.id')

	# Find which workspace our window is currently in
	set win_workspace (hyprctl clients -j | jq -r --arg addr "$my_window" '.[] | select (.address == $addr) | .workspace.id')

	# Notify if our window is NOT visible (on any monitor)
	if not contains -- $win_workspace $visible_workspaces
		if test $code -eq 0
			notify-send -u normal "Done" "$cmd"
		else
			notify-send -u critical "Failed (exit $code)" "$cmd"
		end
	end

	return $code
end
