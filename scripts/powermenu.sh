#!/usr/bin/env bash
# This is a script that i call from polybar

choice=$(printf "Reboot\nShutdown\n" | \
  rofi -dmenu -p "" -theme-str 'window { 
                            width: 130px; 
                            height: 130px; 
                            y-offset: -34px;
                          }' \
    -location 7 -anchor southwest \
)

case "$choice" in
  Reboot)
    wineserver -k -w 2>/dev/null
    systemctl reboot
    ;;
  Shutdown)
    wineserver -k -w 2>/dev/null
    systemctl poweroff
    ;;

esac
