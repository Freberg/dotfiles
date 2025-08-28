

# Hyprland Configuration

This document outlines the Hyprland setup, including keybindings and integrated applications.

## Keybindings

The main modifier key is `SUPER`.

| Keybinding          | Action                                                    | Application/Command                                         |
| :------------------ | :-------------------------------------------------------- | :---------------------------------------------------------- |
| `SUPER + C`         | Kill active window                                        | `killactive`                                                |
| `SUPER + V`         | Toggle floating window                                    | `togglefloating`                                            |
| `SUPER + T`         | Toggle split layout                                       | `togglesplit`                                               |
| `SUPER + P`         | Swap active window with master                            | `layoutmsg, swapwithmaster`                                 |
| `SUPER + O`         | Focus master window                                       | `layoutmsg, focusmaster`                                    |
| `SUPER + B`         | Reload Waybar                                             | `pkill -SIGUSR1 '.*waybar.*'`                               |
| `SUPER + H`         | Move focus left                                           | `movefocus, l`                                              |
| `SUPER + L`         | Move focus right                                          | `movefocus, r`                                              |
| `SUPER + K`         | Move focus up                                             | `movefocus, u`                                              |
| `SUPER + J`         | Move focus down                                           | `movefocus, d`                                              |
| `SUPER + [0-9]`     | Switch to workspace                                       | `workspace, [0-9]`                                          |
| `SUPER + SHIFT + [0-9]` | Move active window to workspace                         | `movetoworkspace, [0-9]`                                    |
| `SUPER + SHIFT + J` | Move current workspace to previous monitor                | `movecurrentworkspacetomonitor, -1`                         |
| `SUPER + SHIFT + K` | Move current workspace to next monitor                    | `movecurrentworkspacetomonitor, +1`                         |
| `SUPER + Scroll Down` | Scroll to next workspace                                | `workspace, e+1`                                            |
| `SUPER + Scroll Up` | Scroll to previous workspace                              | `workspace, e-1`                                            |
| `SUPER + LMB`       | Move window (drag)                                        | `movewindow`                                                |
| `SUPER + RMB`       | Resize window (drag)                                      | `resizewindow`                                              |
| `SUPER + Q`         | Launch terminal                                           | `uwsm app -- $(source ~/.config/theme/env/current && wezterm)` (Wezterm with theme) |
| `SUPER + R`         | Launch application launcher                               | `wofi -i -n --show drun`                                    |
| `SUPER + S`         | Search Google                                             | `wofi -bdi -p "search" -L 10 | xargs -I {} chromium --app="https://www.google.com/search?q={}"` |
| `SUPER + SHIFT + V` | Paste from cliphist                                       | `cliphist list | wofi --dmenu -p "cliphist" | cliphist decode | wl-copy && wtype -M ctrl -M shift v` |
| `SUPER + Tab`       | Window switcher                                           | `bash ~/.config/waybar/scripts/window_menu.sh`              |
| `XF86AudioRaiseVolume` | Increase volume                                           | `pamixer -u -i 5`                                           |
| `XF86AudioLowerVolume` | Decrease volume                                           | `pamixer -u -d 5`                                           |
| `XF86AudioMute`     | Mute/unmute volume                                        | `pamixer -t`                                                |
| `XF86MonBrightnessUp` | Increase brightness                                       | `light -A 5`                                                |
| `XF86MonBrightnessDown` | Decrease brightness                                       | `light -U 5`                                                |
| `Print`             | Screenshot active window to clipboard                     | `grimshot copy window`                                      |
| `SHIFT + Print`     | Screenshot area to clipboard                              | `grimshot copy area`                                        |
| `SUPER + M`         | Exit Hyprland                                             | `exit`                                                      |
| `SUPER + SHIFT + L` | Lock screen                                               | `hyprlock`                                                  |
| `Lid Switch`        | Lock screen on lid close (laptop)                         | `hyprlock`                                                  |

## Integrated Applications

The following applications are integrated and launched by Hyprland:

*   **Wezterm**: The default terminal emulator, configured with the current theme.
*   **Wofi**: Used as an application launcher (`drun`) and for general search.
*   **Chromium**: Used for web searches directly from wofi.
*   **Cliphist**: Clipboard manager.
*   **Waybar**: Status bar.
*   **Hyprpaper**: Wallpaper manager.
*   **Dunst**: Notification daemon.
*   **Pamixer**: Audio control.
*   **Light**: Screen brightness control.
*   **Grimshot**: Screenshot utility.
*   **Hyprlock**: Screen locker.

