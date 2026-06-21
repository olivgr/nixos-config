#!/usr/bin/env bash

xmlstarlet sel \
  -t \
  -m '//keybind' \
  -v '@key' \
  -o ' - ' \
  -v 'description' \
  -n \
  ~/.config/openbox/rc.xml |
rofi -dmenu -i -p "Openbox Keys"
