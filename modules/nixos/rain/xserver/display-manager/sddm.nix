{ config, pkgs, lib, outputs, ... }:

with lib; {
  config = mkIf (config.rain.xserver.display-manager == "sddm") {
    environment.systemPackages = [
      # Deprecated
      # outputs.packages.sddm-rose-pine
      (pkgs.sddm-astronaut.override {
        embeddedTheme = "purple_leaves";
      })
    ];

    services.xserver.displayManager = {
      defaultSession = "xfce+i3";
      sddm = {
        enable = true;
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
