{ config, pkgs, username, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.useWindowsDriver = true;
  
  networking.hostName = "wsl";

  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld;

  services.dbus.enable = true;
  
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    home = "/home/${username}";
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  
  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  system.stateVersion = "25.05";
}
