#!/usr/bin/env bash
# This is a script that i call from polybar

choice=$(printf "vasp/script\nterminal\nfiles\nbrowser\nreaper\nmousepad\nlocalsend\nvolume\nnmtui\n---------\nreboot\npoweroff\n" | \
  fuzzel --dmenu --config ~/.config/fuzzel/fuzzel-power.ini
)

case "$choice" in
  vasp/script)
    #ghostty --window-width=102 --window-height=36 -e ~/nixos/scripts/vaspnvim.sh
    ghostty -e ~/nixos/scripts/vaspnvim.sh
    ;;
  terminal)
    ghostty
    ;;
  files)
    nautilus
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
  nmtui)
    ghostty -e nmtui
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
