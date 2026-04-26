{ pkgs }: {
  terminal = {
    programs.bat.themes."nightfox" = {
      src = pkgs.fetchFromGitHub {
        owner = "EdenEast";
        repo = "nightfox.nvim";
        rev = "main";
        sha256 = "sha256-HoZEwncrUnypWxyB+XR0UQDv+tNu1/NbvimxYGb7qu8=";
      };
      file = "extra/nightfox/nightfox.tmTheme";
    };
  };
  desktop = {
    gtkThemeSource = "${pkgs.nightfox-gtk-theme}/share/themes/Nightfox-Dark";
  };
}
