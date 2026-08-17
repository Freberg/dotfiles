{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
    name = "maven-env";
    targetPkgs = pkgs: (with pkgs; [
        maven
        mvnd
        zsh
    ]);
    runScript = "env -u shellHook -u etc_ignored zsh";
}).env
