{ pkgs, ... }:
{
    home.packages = with pkgs; [
        visidata
        fzf
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
