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
    # monitoring
    bottom
    pkgsUnstable.witr
    # networking
    dig
    # nix
    nvd
    # clis
    lazygit
    lazydocker
    pkgsUnstable.fzf
    fd
    delta
    glab
    gh
    # database tools
    (pkgsUnstable.sqlit-tui.overridePythonAttrs (oldAttrs: {
      dependencies = (oldAttrs.dependencies or [ ]) ++ (with pkgsUnstable.python3Packages; [
        psycopg2-binary
        pymysql
        oracledb
      ]);
    }))
    # data manipulation
    jq
    yq-go
    # explore / preview
    bat
    eza
    file
    lsof
    chafa
    zoxide
    # file management
    rclone
    zip
    unzip
    # clipboard
    wtype
    cliphist
    wl-clipboard
    tesseract
    # correct typos / mistakes
    pay-respects
    # ai
    fabric-ai
    gemini-cli
  ];
  
  programs.zsh = {
    enable = true;
    initContent = "source ~/.config/zsh/zshrc";
  };
}
