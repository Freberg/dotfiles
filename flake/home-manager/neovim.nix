{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    # plugin dependencies
    ripgrep
    gnumake
    # lsps & formatters
    dockerfile-language-server
    docker-compose-language-service
    vscode-extensions.vscjava.vscode-java-debug
    pkgsUnstable.vscode-extensions.vscjava.vscode-java-test
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
