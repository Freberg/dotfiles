{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        python311
        jetbrains.pycharm-community
        nodePackages.pyright
    ];
}
