{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };

  xdg = {
    portal = {
      enable = true; 

      extraPortals = with pkgs; [
        xdg-desktop-portal-termfilechooser
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config = {
        niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-termfilechooser
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xwayland-satellite
  ];
}
