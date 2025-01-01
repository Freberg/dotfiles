{ pkgs, ... }:
let
    pkgsUnstable = import <nixpkgs-unstable> {};
in
{
    home.packages = with pkgs; [
        python311
        #nodePackages.pyright
        pkgsUnstable.jetbrains.pycharm-community
    ];
}
