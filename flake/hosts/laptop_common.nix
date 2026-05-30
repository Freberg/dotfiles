{
  pkgs,
    ...
}:
{
  imports = [
    ./workstation_common.nix
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
