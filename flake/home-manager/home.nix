{
  username,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./terminal.nix
    ./ui.nix
    ./util.nix
    ./zed.nix
    ./development.nix
    ./java_development.nix
    ./python_development.nix
    ./kubernetes.nix
    ./neovim.nix
    ./antivirus.nix
    ./email.nix
  ];
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.jetbrains-mono
    # browser
    firefox
    chromium
    # ai
    fabric-ai
    pkgsUnstable.gemini-cli
    nodejs_24
    uv
  ];

  home.file.".themes/Gruvbox-Dark"= {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Dark";
    recursive = true;
  };
  home.file.".themes/Gruvbox-Light"= {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Light";
    recursive = true;
  };
  home.file.".themes/Nordic" = {
    source = "${pkgs.nordic}/share/themes/Nordic";
    recursive = true;
  };
  home.file.".themes/Dracula" = {
    source = "${pkgs.dracula-theme}/share/themes/Dracula";
    recursive = true;
  };

  xdg.portal.config.common.default = "*";
  wayland.windowManager.hyprland.systemd.enable = false;

  home.stateVersion = "24.11";
}
