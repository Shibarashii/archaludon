-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  -- hl.exec_cmd("nm-applet")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("hyprctl reload")
  hl.exec_cmd("sh -c 'echo disabled | sudo tee /sys/bus/usb/devices/3-2.4/power/wakeup'")  --disable mouse wakeup

end)