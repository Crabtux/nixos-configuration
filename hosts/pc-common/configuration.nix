{ inputs, outputs, pkgs, ... }:

{
  imports = [ 
    ../../modules/nixos/xserver
    ../../modules/nixos/user.nix

    ./s-config.nix
    ./software/config.nix
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
