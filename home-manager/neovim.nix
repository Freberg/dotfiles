{ pkgs, ... }:
let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
{
  home.packages = with pkgs; [
    # plugin dependencies
    ripgrep
    gnumake
    # lsps & formatters
    lua-language-server
    nixd
    nixfmt-rfc-style
    pyright
    ruff
    bash-language-server
    # neovim
    pkgsUnstable.neovim
  ];
}
