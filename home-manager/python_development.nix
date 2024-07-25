{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        python311
        nodePackages.pyright
    ];
}
