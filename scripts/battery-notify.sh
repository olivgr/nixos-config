#!/usr/bin/env bash
bat_path="/sys/class/power_supply/BAT0"
if [ ! -d "$bat_path" ]; then
	notify-send "Battery" "No battery - desktop system" --expire-time=3000
	exit 0
fi

battery=$(cat "$bat_path/capacity")
status=$(cat "bat_path/status")
notify-send "Battery" "$battery% - $status" --expire-time=3000
