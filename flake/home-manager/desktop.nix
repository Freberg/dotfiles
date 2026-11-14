{
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
    pkgsUnstable.kitty
    wezterm
    # IDEs
    pkgsUnstable.intellij-idea
    pkgsUnstable.pycharm
    pkgsUnstable.jetbrains-gateway
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

  xdg.desktopEntries."kitty-tmux" = {
    name = "kitty+tmux";
    genericName = "Terminal Emulator";
    comment = "Kitty without keybindings for tmux";
    exec = "kitty --config \"~/.config/kitty/base.conf\" tmux";
    icon = "kitty";
    terminal = false;
    categories = [ "System" "TerminalEmulator" ];
  };
}
