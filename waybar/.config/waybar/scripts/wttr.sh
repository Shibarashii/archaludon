#!/bin/bash
LOCATION="Santa+Cruz,Laguna"
CACHE="$HOME/.cache/waybar-wttr.json"
CACHE_MAX_AGE=900 # 15 minutes (in seconds)

# 1. If fresh cache exists, output it immediately and exit
if [ -f "$CACHE" ]; then
    age=$(( $(date +%s) - $(stat -c %Y "$CACHE") ))
    if [ $age -lt $CACHE_MAX_AGE ]; then
        cat "$CACHE"
        exit 0
    fi
fi

# 2. Fetch condition (%C) and temperature (%t) in ONE single request
data=$(curl -s --connect-timeout 5 --max-time 15 "https://wttr.in/${LOCATION}?format=%C|%t" | tr -d '\n')
condition=$(echo "$data" | cut -d'|' -f1)
temp=$(echo "$data" | cut -d'|' -f2)

# 2. Fetch 2-day ASCII forecast for tooltip
forecast=$(curl -s --connect-timeout 5 --max-time 15 "https://wttr.in/${LOCATION}?2QnT" | sed '/^Follow/d; /^$/d')

# If request failed or timed out, fall back to last saved cache
if [ -z "$temp" ]; then
    if [ -f "$CACHE" ]; then
        cat "$CACHE"
    else
        echo '{"text": "<span color=\"#f38ba8\" font_weight=\"medium\">N/A</span>", "tooltip": "Weather unavailable"}'
    fi
    exit 0
fi

# 3. Map condition text to your custom Nerd Font icons & Catppuccin colors
case "$condition" in
    *"Sunny"*|*"Clear"*)                      icon="<span color='#f9e2af'>󰖙</span>" ;; # Sun
    *"Partly cloudy"*|*"Partly Cloudy"*)       icon="<span color='#89b4fa'>󰖕</span>" ;; # Sun + Cloud
    *"Cloudy"*|*"Overcast"*)                   icon="<span color='#6c7086'>󰖐</span>" ;; # Cloud
    *"Fog"*|*"Mist"*)                          icon="<span color='#9399b2'>󰖑</span>" ;; # Fog
    *"rain"*|*"Rain"*|*"Drizzle"*|*"drizzle"*) icon="<span color='#89b4fa'>󰖖</span>" ;; # Rain
    *"Thunder"*|*"thunder"*|*"storm"*)         icon="<span color='#fab387'>󰖓</span>" ;; # Thunderstorm
    *"Snow"*|*"snow"*|*"Ice"*|*"ice"*)         icon="<span color='#cdd6f4'>󰖘</span>" ;; # Snow
    *)                                         icon="<span color='#f9e2af'>󰖙</span>" ;; # Default
esac

# 4. Colorize forecast tooltip with Catppuccin colors
if [ -n "$forecast" ]; then
    forecast=$(echo "$forecast" | \
      sed "s/Sunny/<span color='#f9e2af'>Sunny<\/span>/g" | \
      sed "s/Partly Cloudy/<span color='#89b4fa'>Partly Cloudy<\/span>/g" | \
      sed "s/Overcast/<span color='#7f849c'>Overcast<\/span>/g" | \
      sed "s/rain/<span color='#89b4fa'>rain<\/span>/g" | \
      sed "s/°C/<span color='#a6e3a1'>°C<\/span>/g" | \
      sed "s/km\/h/<span color='#94e2d5'>km\/h<\/span>/g")

    tooltip=$(echo "$forecast" | sed 's/\\/\\\\/g; s/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
    tooltip="<span color='#cdd6f4' font_weight='bold' size='smaller'><tt>${tooltip}</tt></span>"
else
    tooltip="<b><span color='#a6e3a1'>${condition}</span></b> (${temp})"
fi

# 5. Build formatted Waybar text
text="<span size='250%'>${icon}</span> <span rise='7pt' font_weight='extrabold' size='medium' color='#cdd6f4'>${temp}</span>"

output="{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"

# Output to Waybar and save to cache
echo "$output" | tee "$CACHE"
