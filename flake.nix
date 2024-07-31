{
  description = "Just a very basic flake for my daliy use";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: 
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = import ./pkgs pkgs;
      overlays = import ./overlays { inherit inputs pkgs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        wujie = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = 
            [
              ./hosts/wujie
              nur.nixosModules.nur
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.crabtux = import ./hosts/wujie/home.nix;
                home-manager.extraSpecialArgs = { inherit inputs outputs; };
              }
            ];
        };
      };

      homeConfigurations = {
        nebula-hpc = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit nixpkgs system; };
          modules = [
            ./hosts/nebula-hpc/home.nix
          ];
        };
      };
    };
}
