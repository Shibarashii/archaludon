# Hyprland

Hyprland window manager configuration with a modular Lua-based setup.

![Preview](img/full-hyprland.png)

## Details

| | |
|---|---|
| **Config format** | Lua (native Hyprland scripting API) |
| **Layout** | Scrolling (default), Dwindle, Master |
| **Theme** | Catppuccin Mocha — green/teal gradient borders |
| **Rounding** | 20px with backdrop blur |
| **Workspaces** | 5 per monitor via `split-monitor-workspaces` plugin |
| **Monitors** | DP-1 @ 60Hz (secondary), DP-2 @ 165Hz (primary) |
| **Wallpaper** | Hyprpaper |

## Module Structure

```
modules/
├── autostart.lua     # Startup services
├── colors.lua        # Catppuccin Mocha palette
├── decorations.lua   # Borders, blur, shadows, animations
├── env.lua           # Wayland environment variables
├── input.lua         # Keyboard & mouse config
├── keybinds.lua      # All keybindings
├── layout.lua        # Layout settings
├── misc.lua          # Miscellaneous
├── monitors.lua      # Monitor setup
└── windowrules.lua   # Per-app rules & layer rules
```

## Key Bindings

| Keybind | Action |
|---|---|
| `Super + C` | Terminal (Kitty) |
| `Super + E` | File manager (Yazi) |
| `Super + Space` | App launcher (Rofi) |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + N` | Notification center |
| `Super + H/J/K/L` | Move focus |
| `Super + 1–0` | Switch workspace |
| `Super + Shift + S` | Screenshot (region → Swappy) |
