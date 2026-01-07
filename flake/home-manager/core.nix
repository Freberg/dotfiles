{ ... }:
{
  imports = [
    ./ai.nix
      ./terminal.nix
      ./neovim.nix
      ./kubernetes.nix
      ./development.nix
      ./java_development.nix
      ./python_development.nix
  ];
}
