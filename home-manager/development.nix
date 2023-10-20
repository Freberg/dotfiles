{ config, pkgs, ... }:
let
    pkgsUnstable = import <nixpkgs-unstable> {};
in
{
    home.packages = with pkgs; [
        pkgsUnstable.act
    ];
}
