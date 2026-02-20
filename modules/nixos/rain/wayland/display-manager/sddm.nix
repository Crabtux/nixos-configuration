{ config, lib, ... }:

with lib; {
  config = mkIf (config.rain.wayland.display-manager == "sddm") {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
  };
}
