{ config, lib, ... }:

{
  config = lib.mkIf config.rain.home-manager.software.cli.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
