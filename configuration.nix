{ pkgs, lib, ... }:

{
    imports =
        [
        ./hardware-configuration.nix
        ./gnome.nix
        <home-manager/nixos>
        ];

    # bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";

    # networking
    networking.networkmanager.enable = true;

    services.openvpn.servers = {};
    programs.openvpn3.enable = true;

    # time zone.
    time.timeZone = "Europe/Stockholm";

    # internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "sv_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
        LC_TIME = "sv_SE.UTF-8";
    };

    # configure keymap in X11
    services.xserver = {
        enable = true;
        xkb = {
        layout = "se";
        variant = "";
        };
    };

    hardware.pulseaudio.enable = false;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # console keymap
    console.keyMap = "sv-latin1";

    # xdg portal
    services.dbus.enable = true;
    xdg = {
        autostart.enable = true;
        portal = {
            #xdgOpenUsePortal = true;
            enable = true;
            wlr.enable = true;
            extraPortals = with pkgs; [
                #xdg-desktop-portal
                xdg-desktop-portal-hyprland
            ];
        };
    };

    services.displayManager.defaultSession = "hyprland";

    # audio and video
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # compositor and shell
    programs = {
        hyprland.enable = true;
        light.enable = true;
        zsh.enable = true;
    };

    # docker
    virtualisation.docker.enable = true;

    # user
    users.users.freberg = {
        isNormalUser = true;
        description = "Daniel Freberg";
        extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
        shell = pkgs.zsh;
    };

    # allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # packages
    environment.systemPackages = with pkgs; [
        ecryptfs
        clamav
        keyutils
        wget
        killall
        git
        gcc
        sshfs
        nfs-utils
        cifs-utils
        xdg-utils
        xdg-desktop-portal-hyprland
    ];

    # home directory encryption
    security.pam.enableEcryptfs = true;
    boot.kernelModules = [ "ecryptfs" ];

    # lock screen
    security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
    security.pam.services.hyprlock.text = lib.readFile "${pkgs.hyprlock}/etc/pam.d/hyprlock";

    # antivirus
    services.clamav = {
        daemon.enable = true;
        updater.enable = true;
    };

    services.pcscd.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    system.stateVersion = "24.11"; # Did you read the comment?
}
