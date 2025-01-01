{ pkgs, ... }:
{
    programs.hyprland = {
        enable = true;
        withUWSM = true;
    };

    xdg = {
        portal = {
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
            ];
        };
    };

    environment.systemPackages = with pkgs; [
        xdg-desktop-portal-hyprland
    ];
}
