{ pkgs, pkgsUnstable, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = pkgsUnstable.hyprland;
  };

  xdg = {
    portal = {
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
