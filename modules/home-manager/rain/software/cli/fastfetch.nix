{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.rain.home.software.cli.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
}
