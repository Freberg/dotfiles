{ config, pkgs, ... }:
{
    imports = [
        ./ui.nix
        ./util.nix
        ./zed.nix
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
        alacritty
        gnome-terminal
        # shell
        sheldon
        # prompt
        starship
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
        chromium
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

    home.stateVersion = "24.11";

    programs.home-manager.enable = true;
}
