#!/usr/bin/env bash

hyprctl eval '
local current = hl.get_config("layout.single_window_aspect_ratio")

if current[1] == 0 and current[2] == 0 then
    hl.config({
        layout = {
            single_window_aspect_ratio = {1, 1}
        }
    })
else
    hl.config({
        layout = {
            single_window_aspect_ratio = {0, 0}
        }
    })
end
'
