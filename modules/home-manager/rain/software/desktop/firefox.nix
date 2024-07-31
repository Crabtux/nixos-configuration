{ lib, config, ... }:

{
  config = lib.mkIf config.rain.home.software.desktop.enable {
    programs.firefox.enable = true;
  };
}
