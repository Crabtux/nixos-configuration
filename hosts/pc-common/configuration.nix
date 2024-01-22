{ inputs, outputs, pkgs, ... }:

{
  imports = [ 
    ../../modules/nixos/software
    ../../modules/nixos/user.nix
    ../../modules/nixos/xserver

    ./s-config.nix
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
