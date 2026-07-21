function _notify_window_info
	set addr $argv[1]
	set visible_workspaces (hyprctl monitors -j | jq -r '.[].activeWorkspace.id')
	set win_workspace (hyprctl clients -j | jq -r --arg addr "$addr" '.[] | select(.address == $addr) | .workspace.id')
	set is_visible 0
	if contains -- $win_workspace $visible_workspaces
		set is_visible 1
	end
	echo "$win_workspace"
	echo "$is_visible"
end

