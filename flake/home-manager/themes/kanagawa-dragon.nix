{ pkgs }: {
  terminal = {
    programs.bat.themes."kanagawa-dragon" = {
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
    gtkThemeSource = "${(pkgs.stdenvNoCC.mkDerivation {
      pname = "kanagawa-dragon-gtk";
      version = "unstable";

      src = pkgs.fetchFromGitHub {
        owner = "Fausto-Korpsvart";
        repo = "Kanagawa-GKT-Theme";
        rev = "main";
        hash = "sha256-UdMoMx2DoovcxSp/zBZ3PRv/Qpj+prd0uPm1gmdak2E=";
      };

      nativeBuildInputs = [ pkgs.sassc pkgs.gnome-shell ];
      propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];

      installPhase = ''
        mkdir -p $out/share/themes
        cd themes
        patchShebangs install.sh
        ./install.sh -n Kanagawa --tweaks dragon -d "$out/share/themes"
        '';
    })}/share/themes/Kanagawa-Dark-Dragon";
  };
}
