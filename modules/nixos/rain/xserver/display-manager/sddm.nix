{ config, lib, outputs, ... }:

with lib; {
  config = mkIf (config.rain.xserver.display-manager == "sddm") {
    environment.systemPackages = [
      outputs.packages.sddm-rose-pine
    ];

    services.xserver.displayManager = {
      defaultSession = "xfce+i3";
      sddm = {
        enable = true;
        theme = "rose-pine";
      };
    };
  };
}
