{ config, lib, ... }:

let
  cfg = config.rain.home.xsession.window-manager.i3.applet.compositor;
in with lib; {
  config = mkIf (cfg == "picom") {
    services.picom = {
      enable = true;
      fade = true;
      fadeSteps = [
        0.1
        0.1
      ];
    };
  };
}
