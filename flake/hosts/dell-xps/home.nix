{ config, pkgs, pkgsUnstable, ... }:

{ 
  imports = [
    ../../home-manager/core.nix
    ../../home-manager/desktop.nix
  ];
  
  home.stateVersion = "24.11";
}
