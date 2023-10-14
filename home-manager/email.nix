{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        es
        pass
        isync
        msmtp
        neomutt
        mutt-wizard
    ];
}
