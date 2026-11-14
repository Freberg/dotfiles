{
  pkgs,
  ...
}:
let
  # TODO - remove once OSC-7501 support is released (probably v3.9)
  customTmux = pkgs.tmux.overrideAttrs (oldAttrs: {
    version = "unreleased-OSC-7501-support";
    src = pkgs.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "d84b58297a90a47886e599a9e422c9c5f5cf81cc";
      hash = "sha256-7G5hjWTAr+COXMA0pouSHFt40NsAw1kKxbJI83++9m0=";
    };
    doInstallCheck = false;
  });
in
{
  home.packages = with pkgs; [
    # essentials
    git
    vim
    pass
    customTmux
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
    jira-cli-go
    # database tools
    (sqlit-tui.overridePythonAttrs (oldAttrs: {
      dependencies = (oldAttrs.dependencies or [ ]) ++ (with python3Packages; [
        psycopg2
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
