#!/usr/bin/env sh

last=""

while true; do
  cur="$(fcitx5-remote)"

  if [ "$cur" != "$last" ]; then
    if [ "$cur" = "2" ]; then
      polybar-msg action "#fcitx5.hook.1" >/dev/null
    else
      polybar-msg action "#fcitx5.hook.0" >/dev/null
    fi
    last="$cur"
  fi

  sleep 0.5
done

