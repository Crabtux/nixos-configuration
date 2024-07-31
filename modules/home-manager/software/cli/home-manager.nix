{ config, lib, ... }:

{
  config = lib.mkIf config.mySystem.home-manager.software.cli.enable {
    # Enable home-manager
    programs.home-manager.enable = true;
  };
}
