{ config, lib, ... }:

with lib; {
  config = mkIf config.mySystem.system.sound.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/Music";
      user = "mpd";
    };
  };
}
