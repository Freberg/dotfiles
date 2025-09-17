{ config, pkgs, pkgsUnstable, ... }:

{ 
  imports = [
    ../../home-manager/core.nix
  ];
  
  home.stateVersion = "25.05";
}
