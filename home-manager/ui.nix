{ pkgs, ... }:
let
    pkgsUnstable = import <nixpkgs-unstable> {};
in
{
    imports = [
        ./ui_cursor.nix
    ];

    home.packages = with pkgs; [
        pkgsUnstable.waybar
        wofi
        pkgsUnstable.walker
        hyprpaper
        hyprlock
        gtklock
        greetd.gtkgreet
    ];
}
