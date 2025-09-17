{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
    rclone
    zip
    unzip
    thefuck
  ];
}
