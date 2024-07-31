{ lib, config, ... }:

with lib; {
  config = mkIf (config.rain.xserver.desktop-manager == "xfce") {
    # Set xfce as desktop manager without its window manager
    services.xserver.desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };
  };
}
