{ pkgs }: {
  terminal = {
    programs.bat.themes."kanagawa" = {
      src = pkgs.fetchFromGitHub {
        owner = "rebelot";
        repo = "kanagawa.nvim";
        rev = "master";
        sha256 = "sha256-nHcQWTX4x4ala6+fvh4EWRVcZMNk5jZiZAwWhw03ExE=";
      };
      file = "extras/tmTheme/kanagawa.tmTheme";
    };
  };
  desktop = {
    gtkThemeSource = "${pkgs.kanagawa-gtk-theme}/share/themes/Kanagawa-BL-LB";
  };
}
