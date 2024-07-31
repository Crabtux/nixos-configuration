{ lib, config, ... }:

{
  config = lib.mkIf config.mySystem.home-manager.software.desktop.enable {
    programs.firefox.enable = true;
  };
}
