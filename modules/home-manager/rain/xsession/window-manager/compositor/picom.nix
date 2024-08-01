{ config, lib, ... }:

{
  config = lib.mkIf (config.rain.home.xsession.window-manager.i3.applet.compositor == "picom") {
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
