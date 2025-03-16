{ pkgs, ... }:
{
    home.packages = with pkgs; [
      ripgrep
      gnumake
      neovim
    ];
}
