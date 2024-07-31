{ config, lib, ... }:

{
  config = lib.mkIf config.rain.software.desktop.games.enable {
    programs.steam.enable = true;
  };
}
