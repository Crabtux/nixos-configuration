{ config, lib, ... }:

with lib; {
  config = mkIf (config.rain.xserver.display-manager == "gdm") {
    services.xserver.displayManager = {
      gdm.enable = true;
      defaultSession = "xfce+i3";
    };
  };
}
