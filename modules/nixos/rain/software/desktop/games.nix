{ config, lib, ... }:

{
  options = {
    rain.software.desktop.games = {
      enable = lib.mkEnableOption "desktop application";
    };
  };

  config = lib.mkIf config.rain.software.desktop.games.enable {
    programs.steam.enable = true;
  };
}
