{
  system,
  pkgs,
  pkgsUnstable,
  dagger,
  ...
}:
{
  home.packages = with pkgs; [
    vim
    vscode
    act
    ansible
    pkgsUnstable.devpod
    dagger.packages.${system}.dagger
  ];
}
