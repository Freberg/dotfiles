{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    # plugin dependencies
    ripgrep
    gnumake
    # lsps & formatters
    dockerfile-language-server
    docker-compose-language-service
    jdt-language-server
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
