{ config, lib, ... }:

with lib; {
  config = mkIf (config.mySystem.xsession.window-manager.i3.applet.app-menu == "rofi") {
    programs.rofi.enable = true;
  };
}
