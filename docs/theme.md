
# Theming System

This document describes the theming system used in this dotfiles repository, including the `change_theme.sh` script and the structure of theme-related files.

## `change_theme.sh` Script

The `change_theme.sh` script is a central component for switching themes across the system. It takes a single argument: the name of the theme to apply (e.g., `dracula`, `nord`).

### How it Works

1.  **Symlinking Configuration Files**: For each integrated application or component (dunst, env, hypr, kitty, waybar, wofi), the script creates a symbolic link named `current` within the application's theme directory. This `current` link points to the theme-specific configuration files. This allows applications to load their theme by referencing `current`, which dynamically changes based on the active theme.
    *   Example: `~/.config/theme/dunst/current` will point to `~/.config/theme/dunst/nord` if `nord` is the active theme.

2.  **Wallpaper Management**: For wallpapers, the script directly updates the `hyprpaper.conf` file to set the wallpaper for all monitors to the theme-specific wallpaper image (e.g., `~/.config/wallpaper/nord.png`). It then instructs `hyprpaper` to apply the new wallpaper.

3.  **Service Restart/Reload**:
    *   It sends a `SIGUSR2` signal to `waybar` instances, which typically triggers a reload of its configuration and styles.
    *   It kills and restarts `dunst` to apply the new notification theme.

### Usage

To change the theme, run the script with the desired theme name:

```bash
./theme/change_theme.sh nord
```

## Theme Directory Structure

The `theme/` directory organizes theme-specific configurations for various applications. Currently, the supported themes are: Dracula, Gruvbox Dark, Gruvbox Light, and Nord. Each integrated component (like `dunst`, `waybar`, `kitty`, etc.) has a subdirectory within `theme/` containing theme-specific configuration files for these four themes. Additionally, wallpapers are managed in `~/.config/wallpaper/` with corresponding theme-specific images.

## Integrated Components

The theming system currently supports:

*   **Dunst**: Notification daemon theming.
*   **Environment Variables (`env`)**: Theme-specific environment variables that can be sourced by other applications (e.g., terminal color schemes).
*   **Hyprland**: Configuration adjustments related to the theme.
*   **Kitty**: Terminal emulator color schemes.
*   **Waybar**: Status bar styling.
*   **Wofi**: Application launcher styling.
*   **Wallpaper**: Sets the desktop background.
*   **CSS**: Global CSS styles that might be used by various applications.
