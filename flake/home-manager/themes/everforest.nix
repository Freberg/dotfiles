{ pkgs }: {
  terminal = {
    programs.bat.themes."everforest" = {
      src = pkgs.fetchFromGitHub {
        owner = "neuromaancer";
        repo = "everforest_collection";
        rev = "main";
        sha256 = "sha256-HQQzmSYcQY4jYyk7zyxdOSJylqJl4aBobT37pST6AXE=";
      };
      file = "bat/everforest-soft.tmTheme";
    };
  };
  desktop = {
    gtkThemeSource = "${pkgs.everforest-gtk-theme}/share/themes/Everforest-Dark-BL-LB";
  };
}
