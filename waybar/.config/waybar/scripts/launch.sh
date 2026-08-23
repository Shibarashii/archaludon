#!/bin/bash

pkill waybar

# rm -f "$HOME/.cache/waybar-wttr.json"

waybar &

# GTK_DEBUG=interactive waybar &
