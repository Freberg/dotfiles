{ pkgs, pkgsUnstable, ... }:
{
  imports = [
    ./terminal.nix
      ./neovim.nix
      ./util.nix
      ./kubernetes.nix
      ./development.nix
      ./java_development.nix
      ./python_development.nix
  ];
}
