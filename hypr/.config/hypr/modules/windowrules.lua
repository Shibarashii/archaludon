package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")
--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

smw.setup({
    workspace_count = 5, -- This will create 5 persistent workspaces on each monitor at startup
    monitor_priority = { "DP-2", "DP-1" },
})

hl.layer_rule({
    name        = "blur-rofi",
    match       = { namespace = "rofi" },
    blur        = true,
    ignore_alpha = 0.1 
})

hl.layer_rule({
    name = "notification-animation",
    match = { namespace = "swaync-control-center" },
    animation = "slide top",
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name = "notification-window-blur",
    match = { namespace = "swaync-notification-window" },
    blur = true,
    ignore_alpha = 0.5,
})