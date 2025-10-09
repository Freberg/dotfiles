{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  home.packages = with pkgs; [
    # essentials
    git
    vim
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
    # ai
    fabric-ai
    pkgsUnstable.gemini-cli
  ];
  
  programs.zsh = {
    enable = true;
    initContent = "source ~/.config/zsh/zshrc";
  };
}
