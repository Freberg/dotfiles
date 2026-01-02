{ username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nvidia.nix
    ../laptop_common.nix
  ];
  
  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };
}
