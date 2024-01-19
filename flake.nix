{
  description = "Just a very basic flake for my daliy use";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, home-manager, ... }@attrs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
    in {
      packages = import ./pkgs pkgs;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = 
          let
            defaults = { pkgs, ... }: {
              _module.args.nixpkgs-unstable = import nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
            };
          in [
            defaults
            sops-nix.nixosModules.sops
            ./hosts/wujie/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.crabtux = import ./home-manager/home.nix;
            }
          ];
      };
    };
}
