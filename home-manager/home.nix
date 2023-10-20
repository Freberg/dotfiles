{ config, pkgs, ... }:
{
    imports = [
        ./ui.nix
        ./development.nix
        ./java_development.nix
        ./python_development.nix
        ./kubernetes.nix
        ./antivirus.nix
        ./email.nix
    ];
    home.username = "freberg";
    home.homeDirectory = "/home/freberg";
    fonts.fontconfig.enable = true;
  
    home.packages = with pkgs; [
        # fonts
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        # terminal
        kitty
        # shell
        sheldon
        # prompt
        starship
        # cli tools
        jq
        unzip
        # notifications
        libnotify
        dunst
        # clipboard
        cliphist
        wl-clipboard
        sway-contrib.grimshot
        # media
        pamixer
        # browser
        firefox
        # editors
        vim
        # LSPs
        lua-language-server
        nodePackages.bash-language-server
        # tool chains
        rustup
    ];
  
    programs.zsh = {
        enable = true;
        initExtra = "source ~/.config/zsh/zshrc";
    };

    programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            packer-nvim
        ];
    };

    home.stateVersion = "23.05";
 
    programs.home-manager.enable = true;
}
