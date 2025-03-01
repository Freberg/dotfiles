{ pkgs, ... }:
{
    home.packages = with pkgs; [
        visidata
        jq
        rclone
        zip
        unzip
        keepass
        filezilla
        libreoffice
        gimp
    ];
}
