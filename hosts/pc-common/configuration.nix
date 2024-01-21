{ inputs, pkgs, outputs, ... }:

{
  imports = [ 
    ./x-config.nix
    ./s-config.nix
    ./software/config.nix

    ../../home-manager/config.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  networking.networkmanager.enable = true;
}
