{ lib, ... }:

with lib; {
  imports = [
    ./window-manager
  ];

  options = {
    mySystem.xsession.window-manager.i3 = {
      enable = mkEnableOption "i3wm";
      applet = {
        app-menu = mkOption {
          type = types.enum ["disable" "rofi"];
          default = "disable";
          description = "Choose app-menu applet for i3wm";
        };

        bar = mkOption {
          type = types.enum ["disable" "polybar"];
          default = "disable";
          description = "Choose status bar for i3wm";
        };

        compositor = mkOption {
          type = types.enum ["disable" "picom"];
          default = "disable";
          description = "Choose compositor for i3wm";
        };

        screensaver = mkOption {
          type = types.enum ["disable" "i3lock-fancy"];
          default = "disable";
          description = "Choose screensaver for i3wm";
        };
      };
    };
  };
}
