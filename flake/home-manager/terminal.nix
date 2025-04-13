{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  home.packages = with pkgs; [
    # terminal emulator
    kitty
    alacritty
    wezterm
    gnome-terminal
    # prompt
    starship
    # shell
    sheldon
    nushell
    # clis
    lazygit
    lazydocker
    dig
    pkgsUnstable.fzf
    delta
    glab
    gh
    # explore / preview
    bat
    eza
    file
    chafa
    # clipboard
    wtype
    cliphist
    wl-clipboard
    sway-contrib.grimshot
  ];
  
  programs.zsh = {
    enable = true;
    initExtra = "source ~/.config/zsh/zshrc";
  };
}
