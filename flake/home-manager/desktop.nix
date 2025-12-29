{
  username,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./ui.nix
    ./zed.nix
    ./antivirus.nix
    ./email.nix
  ];
  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # terminal emulators
    kitty
    wezterm
    # IDEs
    jetbrains.idea
    jetbrains.pycharm-oss
    jetbrains.gateway
    vscode
    # utils
    keepass
    filezilla
    libreoffice
    gimp
    # fonts
    nerd-fonts.jetbrains-mono
    # browser
    firefox
    chromium
  ];

  home.file.".themes/Everforest" = {
    source = "${pkgs.everforest-gtk-theme}/share/themes/Everforest-Dark-BL-LB";
    recursive = true;
  };
  home.file.".themes/Gruvbox-Dark"= {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Dark";
    recursive = true;
  };
  home.file.".themes/Gruvbox-Light"= {
    source = "${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Light";
    recursive = true;
  };
  home.file.".themes/Kanagawa" = {
    source = "${pkgs.kanagawa-gtk-theme}/share/themes/Kanagawa-BL-LB";
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
}
