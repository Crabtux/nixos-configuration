{ config, lib, ... }:

let
  cfg = config.rain.system.sound.mpd;
in with lib; {
  options = {
    rain.system.sound.mpd = {
      enable = mkEnableOption "mpd";
    };
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/Music";
      user = "mpd";
    };
  };
}
