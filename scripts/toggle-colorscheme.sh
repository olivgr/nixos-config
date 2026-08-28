#!/usr/bin/env bash

LIGHT_THEME="Adwaita"
DARK_THEME="Adwaita-dark"

current=$(dconf read /org/gnome/desktop/interface/color-scheme)

if [[ "$current" == "'prefer-dark'" ]]; then
    # ── Light mode ──────────────────────────────────────────────
    dconf write /org/gnome/desktop/interface/color-scheme "'default'"
    gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME" \
        2>> /tmp/theme-errors.log

    # Neovim
    for server in /run/user/$UID/nvim.*; do
        nvr --server "$server" --nostart --remote-send \
            "<cmd>set background=light<CR>" \
            2>/dev/null
    done

    # Ghostty
    pkill -USR2 -x ghostty 2>/dev/null

    makoctl dismiss
    notify-send "Light mode activated" --expire-time=2000

else
    # ── Dark mode ───────────────────────────────────────────────
    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME" \
        2>> /tmp/theme-errors.log

    # Neovim
    for server in /run/user/$UID/nvim.*; do
        nvr --server "$server" --nostart --remote-send \
            "<cmd>set background=dark<CR>" \
            2>/dev/null
    done

    # Ghostty
    pkill -USR2 -x ghostty 2>/dev/null

    makoctl dismiss
    notify-send "Dark mode activated" --expire-time=2000
fi
