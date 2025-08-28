

# Waybar Configuration

This document describes the Waybar setup, including its modules, integrated applications, and custom scripts.

## Modules

Waybar is configured with the following modules:

Waybar is configured with the following modules, which are listed in order of appearance from left to right:

*   **hyprland/workspaces**: Displays Hyprland workspaces.
*   **hyprland/window**: Shows the title of the active window.
*   **tray**: System tray for background applications.
*   **custom/devpod**: Displays the number of active DevPods. Uses [`devpod_status.sh`](../waybar/scripts/devpod_status.sh) for status and [`devpod_menu.sh`](../waybar/scripts/devpod_menu.sh) for actions.
*   **custom/docker**: Displays the number of running Docker containers. Uses [`docker_status.sh`](../waybar/scripts/docker_status.sh) for status and [`docker_menu.sh`](../waybar/scripts/docker_menu.sh) for actions.
*   **pulseaudio**: Controls audio volume.
*   **pulseaudio#microphone**: Controls microphone volume.
*   **battery**: Displays battery status and capacity.
*   **custom/vpn**: Shows VPN connection status. Uses [`vpn_status.sh`](../waybar/scripts/vpn_status.sh) for status and [`vpn_menu.sh`](../waybar/scripts/vpn_menu.sh) for actions.
*   **custom/network**: Displays network connection status (Wi-Fi or Ethernet). Uses [`network_status.sh`](../waybar/scripts/network_status.sh) for status and [`network_menu.sh`](../waybar/scripts/network_menu.sh) for actions.
*   **clock**: Displays current time and date.

The scripts in `waybar/scripts/` are used to provide dynamic content and interactive menus for the custom modules:

*   [`devpod_menu.sh`](../waybar/scripts/devpod_menu.sh): Manages DevPod instances.
*   [`devpod_status.sh`](../waybar/scripts/devpod_status.sh): Provides DevPod status for display.
*   [`docker_menu.sh`](../waybar/scripts/docker_menu.sh): Manages Docker containers.
*   [`docker_status.sh`](../waybar/scripts/docker_status.sh): Provides Docker container status for display.
*   [`network_menu.sh`](../waybar/scripts/network_menu.sh): Manages Wi-Fi connections and displays network information.
*   [`network_status.sh`](../waybar/scripts/network_status.sh): Provides network connection status for display.
*   [`vpn_menu.sh`](../waybar/scripts/vpn_menu.sh): Connects or disconnects VPN connections.
*   [`vpn_status.sh`](../waybar/scripts/vpn_status.sh): Provides VPN connection status for display.
*   [`window_menu.sh`](../waybar/scripts/window_menu.sh): Displays open windows and allows switching.
*   [`util.sh`](../waybar/scripts/util.sh): Provides utility functions for other Waybar scripts.

