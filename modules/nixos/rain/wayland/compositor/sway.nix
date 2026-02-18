{ config, lib, pkgs, ... }:

with lib; {
  config = mkIf (config.rain.wayland.enable && config.rain.wayland.compositor == "sway") {
    programs.sway.enable = true;

    # Basic Wayland portal support (screensharing/screenshot/flatpak).
    xdg.portal.wlr.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
