require("bindings")

hl.env("GDK_SCALE", "1.5")

hl.on("hyprland.start", function () 
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 16")
  hl.exec_cmd("uwsm app -- waybar")
  hl.exec_cmd("uwsm app -- swww-daemon && swww img $HOME/.config/wallpaper/current")
  hl.exec_cmd("uwsm app -- swaync")
  hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
  hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
end)

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})
hl.monitor({
  output = "DP-2",
  mode = "preferred",
  position = "auto",
  scale = 1.25,
})
hl.monitor({
  output = "DP-3",
  mode = "preferred",
  position = "auto",
  scale = 3,
})
hl.monitor({
  output = "desc:LG Electronics 34GN850 004NTUW70814",
  mode = "3440x1440@60",
  position = "0x0",
  scale = 1,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })

hl.curve( "my_spring", { type = "spring", mass = 1, stiffness = 70, dampening = 20 })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "my_spring", style = "slidevert" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "my_spring" })

hl.config({
  input = {
    follow_mouse = 0,
    kb_layout = "se",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    touchpad = {
      natural_scroll = false
    },
  },
  general = {
    gaps_in = 2,
    gaps_out = 2,
    border_size = 1,
    layout = "master",
  },
  decoration = {
    rounding = 0,
  },
  master = {
    new_status = "master",
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
  misc = {
    key_press_enables_dpms = true,
    disable_hyprland_logo = true,
  },
})

