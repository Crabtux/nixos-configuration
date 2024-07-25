{ config, lib, ... }:

{
  config = lib.mkIf (config.mySystem.xsession.window-manager.i3.applet.compositor == "picom") {
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
