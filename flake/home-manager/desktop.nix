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
    alacritty
    wezterm
    gnome-terminal
    # IDEs
    jetbrains.idea-ultimate
    jetbrains.pycharm-community
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
}
