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

  xdg.portal.config.common.default = "*";
  wayland.windowManager.hyprland.systemd.enable = false;
}
