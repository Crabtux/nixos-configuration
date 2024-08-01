{ config, lib, ... }:

let
  cfg = config.rain.home.xsession.window-manager.i3.applet.app-menu;
in with lib; {
  config = mkIf (cfg == "rofi") {
    programs.rofi.enable = true;
  };
}
