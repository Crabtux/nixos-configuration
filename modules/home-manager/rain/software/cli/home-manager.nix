{ config, lib, ... }:

{
  config = lib.mkIf config.rain.home-manager.software.cli.enable {
    # Enable home-manager
    programs.home-manager.enable = true;
  };
}
