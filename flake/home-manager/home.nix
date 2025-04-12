{
  username,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
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
    # terminal
    kitty
    alacritty
    wezterm
    gnome-terminal
    file
    bat
    chafa
    eza
    dig
    pkgsUnstable.fzf
    delta
    glab
    # shell
    sheldon
    nushell
    # prompt
    starship
    # notifications
    libnotify
    dunst
    # clipboard
    wtype
    cliphist
    wl-clipboard
    sway-contrib.grimshot
    # browser
    firefox
    chromium
    # editors
    vim
    # LSPs
    nodePackages.bash-language-server
    # tool chains
    rustup
    # ai
    fabric-ai
  ];

  programs.zsh = {
    enable = true;
    initExtra = "source ~/.config/zsh/zshrc";
  };

  xdg.portal.config.common.default = "*";
  wayland.windowManager.hyprland.systemd.enable = false;

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
