{ lib, isDesktop, ... }:
{
  imports = [
    ./core.nix
  ] ++ lib.optionals isDesktop [
    ./desktop.nix
  ];
}
