{ config, lib, ... }:

{
  config = lib.mkIf config.rain.home.software.cli.enable {
    # Enable home-manager
    programs.home-manager.enable = true;
  };
}
