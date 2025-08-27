
# Freberg's Dotfiles

![CI Build Status](https://github.com/Freberg/dotfiles/actions/workflows/flake-check.yml/badge.svg)

This repository contains my personal dotfiles, managed using Nix flakes for a reproducible and consistent development environment. It includes configurations for various tools and applications, ensuring a streamlined setup across different systems.

## Features

*   Nix Flake Powered: A fully reproducible development environment using Nix flakes and Home Manager.
*   Declarative Configuration: All configurations are declaratively defined, making it easy to understand, modify, and replicate.
*   Hyprland: Configuration for the Hyprland Wayland compositor.
*   Neovim: Personalized Neovim setup for efficient code editing.
*   Zsh: Custom Zsh configuration with plugins for an enhanced shell experience.
*   Wezterm: Terminal emulator configuration.
*   Waybar/Wofi: Status bar and application launcher configurations.
*   Starship: Cross-shell prompt.
*   Nushell: Modern shell configuration.

## Installation and Usage

This repository uses Nix flakes for managing the development environment. The configuration folders (e.g., `hypr/`, `zsh/`) are *not* currently part of the Nix build process. Instead, they are managed via symlinks created by the `install_dot_files.sh` script. Both methods should be used.

### Flake Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Freberg/dotfiles
    ```

2.  **Apply and Update the Flake:**
    To apply your NixOS configuration with these dotfiles, use:
    ```bash
    sudo nixos-rebuild switch --flake ~/dotfiles#dellXps
    ```

### Configuration Files (Symlinks)

The configuration files for tools not managed directly by Nix (e.g., Hyprland, Zsh) are located in their respective directories within this repository.

1.  **Review the `install_dot_files.sh` script:**
    Examine the `install_dot_files.sh` script to understand how it creates symlinks for these configurations.

2.  **Run the installation script:**
    ```bash
    ~/.config/dotfiles/install_dot_files.sh
    ```
    This script will create the necessary symlinks in your home directory, pointing to the configuration files in this repository.

