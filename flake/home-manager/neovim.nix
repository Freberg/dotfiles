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
    vscode-extensions.vscjava.vscode-java-debug
    lua-language-server
    nixd
    nixfmt-rfc-style
    pyright
    ruff
    bash-language-server
    vscode-css-languageserver
    # neovim
    pkgsUnstable.neovim
  ];
}
