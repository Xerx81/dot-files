-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function () 
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("hyprctl setcursor ArcDusk-cursors 24")
end)

