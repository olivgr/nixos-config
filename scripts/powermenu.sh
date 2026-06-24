#!/usr/bin/env bash
# This is a script that i call from polybar

choice=$(printf "script\nterminal\nfiles\nbrowser\nreaper\nmousepad\nlocalsend\nvolume\n---------\nreboot\npoweroff\n" | \
  rofi -dmenu -p "" -theme-str 'window { 
                            width: 130px; 
                            height: 300px; 
                            x-offset: 5px;
                            y-offset: -5px;
                          }' \
    -location 7 -anchor southwest \
)

case "$choice" in
  script)
    ghostty --window-width=102 --window-height=36 -e ~/nixos/scripts/vaspnvim.sh
    ;;
  terminal)
    ghostty
    ;;
  files)
    pcmanfm
    ;;
  browser)
    firefox
    ;;
  reaper)
    pw-jack reaper
    ;;
  localsend)
    localsend_app
    ;;
  mousepad)
    mousepad
    ;;
  volume)
    pavucontrol
    ;;
  reboot)
    wineserver -k -w 2>/dev/null
    systemctl reboot
    ;;
  poweroff)
    wineserver -k -w 2>/dev/null
    systemctl poweroff
    ;;

esac
