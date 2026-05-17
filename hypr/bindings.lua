-- Common
local mainMod = "SUPER"

local function dispatchLayoutMessage(master_cmd, scrolling_cmd)
  local current_layout = hl.get_config("general:layout")
  if master_cmd and current_layout == "master" then
    hl.dispatch(hl.dsp.layout(master_cmd))
  elseif scrolling_cmd and current_layout == "scrolling" then
    hl.dispatch(hl.dsp.layout(scrolling_cmd))
  end
end

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))

-- Layout management
hl.bind(mainMod .. " + SHIFT + P", function() dispatchLayoutMessage("swapwithmaster") end)
hl.bind(mainMod .. " + SHIFT + O", function() dispatchLayoutMessage("focusmaster") end)
hl.bind(mainMod .. " + SHIFT + H", function() dispatchLayoutMessage("addmaster", "swapcol l") end)
hl.bind(mainMod .. " + SHIFT + L", function() dispatchLayoutMessage("removemaster", "swapcol r") end)
hl.bind(mainMod .. " + F", function() dispatchLayoutMessage("mfact +0.25", "colresize +conf") end)
hl.bind(mainMod .. " + D", function() dispatchLayoutMessage("mfact -0.25", "colresize -conf") end)
hl.bind(mainMod .. " + B", function()
  if hl.get_config("general:layout") == "master" then
    hl.config({ general = { layout = "scrolling" } })
  else
    hl.config({ general = { layout = "master" } })
  end
end)

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces / move windows between workspaces
for i = 0, 9 do
  local key = tostring(i)
  local ws = i == 0 and "10" or tostring(i)
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws, follow = false }))
end

-- Move workspaces between monitors
hl.bind(mainMod .. " + CTRL + P", hl.dsp.workspace.move({workspace = ws, monitor = "-1"}))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.workspace.move({workspace = ws, monitor = "+1"}))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Launchers
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("uwsm app -- kitty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/scripts/ui/app_menu.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/scripts/ui/cliphist_menu.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("grimshot copy area && notify-send 'Print Screen' 'Area copied to clipboard'"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("grimshot save area - | satty --early-exit -f - -o - | wl-copy"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("f=/tmp/ocr.png; grimshot save area $f && (tesseract $f - | wl-copy && notify-send 'OCR' 'Text copied to clipboard'; rm -f $f)"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("~/.config/scripts/ui/window_menu.sh"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("pkill waybar || waybar"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("~/.config/scripts/ui/theme_menu.sh"))

-- Media keys (No modifier required)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -u -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -u -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("light -A 5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("light -U 5"), { locked = true, repeating = true })

-- Exit & Lock
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))

-- Switch/Lid binding
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"))

