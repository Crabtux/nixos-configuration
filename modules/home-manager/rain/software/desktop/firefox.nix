{ lib, config, ... }:

{
  config = lib.mkIf config.rain.home-manager.software.desktop.enable {
    programs.firefox.enable = true;
  };
}
