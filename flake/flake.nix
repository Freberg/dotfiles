{
  description = "A flake for my development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nixos-wsl,
      home-manager,
      dagger,
      ...
    }:
    let
      username = "freberg";
      mkUnstable = system: import nixpkgs-unstable {
        localSystem = { inherit system; };
      };
      sharedModules = system: [
        { nixpkgs.hostPlatform = system; }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit username dagger;
            pkgsUnstable = mkUnstable system;
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        dellXps = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit username; };
          modules = [ ./hosts/dell-xps ] ++ (sharedModules "x86_64-linux");
        };

        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit username; 
            wsl-module = nixos-wsl.nixosModules.default;
          };
          modules = [ ./hosts/wsl ] ++ (sharedModules "x86_64-linux");
        };
      };
    };
}
