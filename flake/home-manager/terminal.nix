{
  pkgs,
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
    witr
    # networking
    dig
    # nix
    nvd
    # clis
    lazygit
    lazydocker
    fzf
    fd
    delta
    glab
    gh
    # database tools
    (sqlit-tui.overridePythonAttrs (oldAttrs: {
      dependencies = (oldAttrs.dependencies or [ ]) ++ (with python3Packages; [
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
    # news
    newsboat
    sqlite
  ];
  
  programs.zsh = {
    enable = true;
    initContent = "source ~/.config/zsh/zshrc";
  };

  programs.bash = {
    enable = true;
    initExtra = "source ~/.config/bash/bashrc";
  };

  programs.bat.enable = true;
}
