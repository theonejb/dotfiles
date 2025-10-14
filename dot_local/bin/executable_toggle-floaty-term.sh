#!/usr/bin/env bash

# Get list of clients and check if Alacritty exists on special:floaty workspace
CLIENT_EXISTS=$(hyprctl clients -j | jq -r '.[] | select(.class == "Alacritty" and .workspace.name == "special:floaty") | .class' | head -n1)

if [ -n "$CLIENT_EXISTS" ]; then
    # Alacritty window exists on special:floaty, toggle the workspace
    hyprctl dispatch togglespecialworkspace floaty
else
    # No Alacritty window on special:floaty, create one
    hyprctl dispatch exec '[workspace special:floaty; float; center; size 50% 70%] alacritty'
fi
