{ config, pkgs, lib, sops, ... }:

{
  imports = [ 
    ./x-config.nix
    ./s-config.nix

    ../../software/config.nix
    ../../home-manager/config.nix
  ];

  networking.networkmanager.enable = true;
}
