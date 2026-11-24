{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    # plugin dependencies
    ripgrep
    gnumake
    luarocks
    pkgsUnstable.tree-sitter
    # lsps
    dockerfile-language-server
    docker-compose-language-service
    vscode-extensions.vscjava.vscode-java-debug
    pkgsUnstable.vscode-extensions.vscjava.vscode-java-test
    lua-language-server
    nixd
    pyright
    bash-language-server
    vscode-css-languageserver
    # formatters
    nixfmt
    prettier
    ruff
    shfmt
    # neovim
    pkgsUnstable.neovim
  ];
}
