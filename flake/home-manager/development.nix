{
  pkgs,
  dagger,
  ...
}:
{
  home.packages = with pkgs; [
    # ci
    act
    ansible
    devpod
    dagger.packages.${pkgs.stdenv.hostPlatform.system}.dagger
    # misc tooling
    nodejs_24
  ];
}
