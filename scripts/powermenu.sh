#!/usr/bin/env bash
# This is a script that i call from polybar

choice=$(printf "script\nterminal\nfiles\nbrowser\nreaper\nmousepad\nlocalsend\nvolume\n---------\nreboot\npoweroff\n" | \
  fuzzel --dmenu --hide-prompt --anchor=bottom-left --width=10 --lines=12 --horizontal-pad=10
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
