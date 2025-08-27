{
  description = "A flake for my development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      dagger,
    }@inputs:
    let
      username = "freberg";
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        dellXps = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit username; };
          modules = [
            ./hosts/dell-xps
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  system
                  username
                  pkgsUnstable
                  dagger
                  ;
              };
              home-manager.users.freberg = ./home-manager/home.nix;
            }
          ];
        };
      };
      #checks = {
      #  "${system}" = nixpkgs.lib.mapAttrs (
      #  hostname: nixosConfig:
      #    nixosConfig.config.system.build.toplevel
      #  ) self.nixosConfigurations;
      #};
    };
}
