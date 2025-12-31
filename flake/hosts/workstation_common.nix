{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../features/audio/default.nix
    ../features/gnome/default.nix
    ../features/hyprland/default.nix
    ../features/niri/default.nix
    ../features/kanata/default.nix
  ];

  services.displayManager.defaultSession = "niri";

  xdg.portal = {
    enable = true;
    config = {
      common = {
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };
}
