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
        inherit system;
      };

      mkNixosSystem = { system, hostname, extraModules ? [ ] }:
        let pkgsUnstable = mkUnstable system;
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit username pkgsUnstable; };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit username dagger pkgsUnstable; };
            }
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        dellXps = mkNixosSystem {
          system = "x86_64-linux";
          hostname = "dell-xps";
        };

        wsl = mkNixosSystem {
          system = "x86_64-linux";
          hostname = "wsl";
          extraModules = [ nixos-wsl.nixosModules.default ];
        };
      };
    };
}
