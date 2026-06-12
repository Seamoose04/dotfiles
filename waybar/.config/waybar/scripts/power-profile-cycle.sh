#!/bin/bash

CURRENT=$(powerprofilesctl get)

case "$CURRENT" in
    "performance") NEXT="balanced" ;;
    "balanced")    NEXT="power-saver" ;;
    "power-saver") NEXT="performance" ;;
esac

powerprofilesctl set "$NEXT"

# Notify
notify-send -a "Power Profile" "Switched to $NEXT" -t 2000
