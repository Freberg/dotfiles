{ pkgs, lib, isDesktop, ... }:
let
  themeData = lib.mapAttrs' (filename: _:
    let
      name = lib.removeSuffix ".nix" filename;
    in
    lib.nameValuePair name (import (./. + "/${filename}") { inherit pkgs; })
  ) (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
  (builtins.readDir ./.));
in
lib.mkMerge [
  (lib.mkMerge (lib.mapAttrsToList (_: data: data.terminal or {}) themeData))

  (lib.mkIf isDesktop {
    home.file = lib.mapAttrs' (name: data: lib.nameValuePair
      ".themes/${name}"
      { source = data.desktop.gtkThemeSource; recursive = true; }
    ) (lib.filterAttrs (_: v: v ? desktop.gtkThemeSource) themeData);
  })
]
