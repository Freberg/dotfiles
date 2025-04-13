{
  username,
  pkgs,
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
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # notifications
    libnotify
    dunst
    # browser
    firefox
    chromium
    # editors
    vim
    # tool chains
    rustup
    # ai
    fabric-ai
  ];

  xdg.portal.config.common.default = "*";
  wayland.windowManager.hyprland.systemd.enable = false;

  home.stateVersion = "24.11";
}
