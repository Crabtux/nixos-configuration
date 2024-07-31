{ config, lib, ... }:

with lib; {
  config = mkIf config.rain.system.sound.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/Music";
      user = "mpd";
    };
  };
}
