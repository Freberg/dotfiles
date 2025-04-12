{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    python311
    pkgsUnstable.jetbrains.pycharm-community
  ];
}
