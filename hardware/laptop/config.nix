{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./laptop-hardware.nix
  ];
}
