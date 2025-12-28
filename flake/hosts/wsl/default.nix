{ config, pkgs, username, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  nix.settings = {
    extra-experimental-features = [ "nix-command" "flakes" ];
  };

  wsl.enable = true;
  wsl.defaultUser = username;
  
  networking.hostName = "wsl";

  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld;
  
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
