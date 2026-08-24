#!/bin/bash

pkill waybar
pkill swaync


# rm -f "$HOME/.cache/waybar-wttr.json"

waybar &
swaync &

# GTK_DEBUG=interactive waybar &
