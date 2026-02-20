{ config, pkgs, lib, ... }:

with lib; {
  config = mkIf (config.rain.wayland.display-manager == "sddm") {
    environment.systemPackages = [
      # Deprecated
      # outputs.packages.sddm-rose-pine
      (pkgs.sddm-astronaut.override {
        embeddedTheme = "purple_leaves";
      })
    ];

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
        ];
      };
    };
  };
}
