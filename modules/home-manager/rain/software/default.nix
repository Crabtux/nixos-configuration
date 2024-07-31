{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop
    ./cli
  ];

  options = {
    rain.home-manager.software = {
      desktop.enable = lib.mkEnableOption "home-manager desktop software";
      cli.enable = lib.mkEnableOption "home-manager CLI software";
    };
  };
}
