{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    python311
  ];
}
