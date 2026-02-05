{
  pkgs,
  pkgsUnstable,
  dagger,
  ...
}:
{
  home.packages = with pkgs; [
    # ci
    act
    ansible
    pkgsUnstable.devpod
    dagger.packages.${pkgs.stdenv.hostPlatform.system}.dagger
    # misc tooling
    nodejs_24
  ];
}
