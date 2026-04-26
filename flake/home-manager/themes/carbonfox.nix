{ pkgs }: {
  terminal = {
    programs.bat.themes."carbonfox" = {
      src = pkgs.fetchFromGitHub {
        owner = "EdenEast";
        repo = "nightfox.nvim";
        rev = "main";
        sha256 = "sha256-HoZEwncrUnypWxyB+XR0UQDv+tNu1/NbvimxYGb7qu8=";
      };
      file = "extra/carbonfox/carbonfox.tmTheme";
    };
  };
  desktop = {
    gtkThemeSource = "${(pkgs.nightfox-gtk-theme.override {
      tweakVariants = [ "carbonfox" ];
      colorVariants = [ "dark" ];
    })}/share/themes/Nightfox-Dark-Carbonfox";
  };
}
