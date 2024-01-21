{ pkgs, self, ... }:

{
  imports = [ 
    ./x-config.nix
    ./s-config.nix
    ./software/config.nix

    ../../home-manager/config.nix
  ];

  nixpkgs = {
    overlays = [
      self.outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  networking.networkmanager.enable = true;
}
