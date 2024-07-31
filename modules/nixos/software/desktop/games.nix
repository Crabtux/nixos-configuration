{ config, lib, ... }:

{
  config = lib.mkIf config.mySystem.software.desktop.games.enable {
    programs.steam.enable = true;
  };
}
