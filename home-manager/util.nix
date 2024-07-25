{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        visidata
        jq
        rclone
        unzip
        keepass
        filezilla
        libreoffice
    ];
}
