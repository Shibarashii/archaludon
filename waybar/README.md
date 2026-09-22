# Waybar

Status bar configuration for Hyprland.

![Preview](img/full-waybar.png)

## Layout

| Zone | Modules |
|---|---|
| **Left** | Hyprland workspaces |
| **Center** | Clock + calendar tooltip, weather widget |
| **Right** | Tray, temperature, CPU, RAM, network, volume, notifications, power drawer |

### Power Drawer

Reveals on click: logout · sleep · reboot · shutdown.

![Power drawer](img/power-profiles.png)

## Details

- Workspace icons via Nerd Fonts; scrollable per-monitor
- Weather fetched every 15 min via `wttr.sh` script
- Notification bell integrates with SwayNC (`swaync-client`)
- All confirmations use `zenity` dialogs
