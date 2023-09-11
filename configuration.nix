{ config, pkgs, lib, sops, ... }:

{
  imports = [ 
    ./software/config.nix
    ./xserver/config.nix
    ./system/config.nix
    ./hardware/laptop/config.nix
    ./user/crabtux/config.nix
  ];

  networking.networkmanager.enable = true;

  # Set the sops
  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  # sops.defaultSopsFile = ./secrets/secrets.json;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
