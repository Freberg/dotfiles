{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        kubectl
        talosctl
        kubernetes-helm
        kind
    ];
}
