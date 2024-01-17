{ config, pkgs, lib, sops, ... }:

{
  imports = [ 
    ./config.nix

    ../software/config.nix
    ../xserver/config.nix
    ../system/config.nix
    ../home-manager/config.nix
  ];

  networking.networkmanager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
