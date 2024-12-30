{ lib, config, pkgs, ... }:
let
    pkgsUnstable = import <nixpkgs-unstable> { 
        config = {
            allowUnfree = true;
        };
    };
    pkgsNur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
in
{

    home.packages = with pkgs; [
        pkgsUnstable.act
        ansible
        gh
        pkgsUnstable.vscode
        pkgsUnstable.devpod
        pkgsUnstable.jetbrains.gateway
        pkgsNur.repos.dagger.dagger
    ];
    
#    nixpkgs.config.allowUnfree = true;

    #nixpkgs.overlays = [
    #    (final: prev: {
    #        pkgsUnstable.jetbrains.gateway.overrideAttrs = (oldAttrs: {
    #            buildInputs = oldAttrs.buildInputs or [] ++ [ pkgs.makeWrapper ];
    #            installPhase = oldAttrs.installPhase or [] ++ ''
    #                mkdir -p $out/share
    #                cp -r . $out/share
    #                rm -r $out/share/jbr
    #            '';
    #            postInstall = oldAttrs.postInstall or "" + ''
    #                wrapProgram \ 
    #                $out/bin/gateway.sh \
    #                $out/bin/jetbrains-gateway \
    #                --prefix LD_LIBRARY_PATH : $out/lib \
    #                --set GATEWAY_JDK "${pkgs.temurin-bin-17}" \
    #                --set JETBRAINS_CLIENT_JDK "${pkgs.temurin-bin-17}" 
    #            '';
    #        });  
    #    })
    #];
}
