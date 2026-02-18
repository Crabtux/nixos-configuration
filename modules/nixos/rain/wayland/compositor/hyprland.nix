{ config, lib, ... }:

with lib; {
  config = mkIf (config.rain.wayland.enable && config.rain.wayland.compositor == "hyprland") {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };
}
