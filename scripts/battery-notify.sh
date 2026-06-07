#!/usr/bin/env bash
bat_path="/sys/class/power_supply/BAT0"
if [ ! -d "$bat_path" ]; then
	notify-send "Battery" "No battery - desktop system" --expire-time=3000
	exit 0
fi

battery=$(cat "$bat_path/capacity")
status=$(cat "bat_path/status")

if [ "$status" = "Full" ] || [ -z "$status" ]; then
	msg="$battery% - Full"
else
	msg="$battery% - $status"
fi

notify-send -u low "Battery: $msg" --expire-time=3000
