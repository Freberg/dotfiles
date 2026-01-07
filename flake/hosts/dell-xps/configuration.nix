{ username, pkgs, lib, ... }:

{
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dell-xps";

  # networking
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  services.openvpn.servers = { };
  programs.openvpn3.enable = true;

  # configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "se";
      variant = "";
    };
  };

  services.hardware.bolt.enable = true;

  # console keymap
  console.keyMap = "sv-latin1";

  # xdg portal
  services.dbus.enable = true;
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  # compositor and shell
  programs = {
    light.enable = true;
    zsh.enable = true;
  };

  # docker
  virtualisation.docker.enable = true;

  # user
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "docker"
    ];
    shell = pkgs.zsh;
  };

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
  ];

  # home directory encryption
  security.pam.enableEcryptfs = true;
  boot.kernelModules = [ "ecryptfs" ];

  # lock screen
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

  system.stateVersion = "24.11";
}
