{ pkgs }: {
  terminal = {
    programs.bat.themes."tokyonight-moon" = {
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "tokyonight.nvim";
        rev = "main";
        sha256 = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
      };
      file = "extras/sublime/tokyonight_moon.tmTheme";
    };
  };
  desktop = {
    gtkThemeSource = "${(pkgs.tokyonight-gtk-theme.override {
      tweakVariants = [ "moon" ];
      colorVariants = [ "dark" ];
    })}/share/themes/Tokyonight-Dark-Moon";
  };
}
