{ config, pkgs, ... }:
{
    home.pointerCursor = 
        let 
        getFrom = url: hash: name: {
            gtk.enable = true;
            x11.enable = true;
            name = name;
            size = 16;
            package = 
                pkgs.runCommand "moveUp" {} ''
                mkdir -p $out/share/icons
                ln -s ${pkgs.fetchzip {
                    url = url;
                    hash = hash;
                }} $out/share/icons/${name}
            '';
        };
    in
        getFrom
        "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.4/Bibata-Modern-Ice.tar.xz"
        "sha256-1U/HoGO/FG/EI6kUqf9sXVL8rfLIsopQLBbDVyxIuX4="
        "Bibata-Modern-Ice";

    gtk = {
        enable = true;
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            #name = "Adwaita";
            size = 16;
        };
    };
}
