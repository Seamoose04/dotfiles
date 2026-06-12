#!/bin/bash
PROFILE=$(powerprofilesctl get)
CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
AC=$(cat /sys/class/power_supply/AC*/online 2>/dev/null | head -1)

# Icon
if   [ "$AC" = "1" ];        then ICON=""
elif [ "$CAPACITY" -ge 90 ]; then ICON=""
elif [ "$CAPACITY" -ge 70 ]; then ICON=""
elif [ "$CAPACITY" -ge 40 ]; then ICON=""
elif [ "$CAPACITY" -ge 20 ]; then ICON=""
else                              ICON=""
fi

# Color: critical/warning override profile color
if   [ "$AC" = "1" ];           then COLOR="#B1E3AD"
elif [ "$CAPACITY" -le 15 ];    then COLOR="#E38C8F"
elif [ "$CAPACITY" -le 30 ];    then COLOR="#B1E3AD"
else
    case "$PROFILE" in
        "performance") COLOR="#f38ba8" ;;
        "balanced")    COLOR="#a6e3a1" ;;
        "power-saver") COLOR="#89b4fa" ;;
    esac
fi

# CSS class
if   [ "$AC" = "1" ];        then CLASS="plugged"
elif [ "$CAPACITY" -le 15 ]; then CLASS="critical"
elif [ "$CAPACITY" -le 30 ]; then CLASS="warning"
else                               CLASS="$PROFILE"
fi

TEXT="<span size='13000' foreground='${COLOR}'>${ICON} </span> ${CAPACITY}%"
TOOLTIP="Battery: ${CAPACITY}%\nProfile: ${PROFILE}"

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$TEXT" "$TOOLTIP" "$CLASS"
