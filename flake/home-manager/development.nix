{
  system,
  pkgs,
  pkgsUnstable,
  dagger,
  ...
}:
{
  home.packages = with pkgs; [
    git
    vim
    act
    ansible
    pkgsUnstable.devpod
    dagger.packages.${system}.dagger
  ];
}
