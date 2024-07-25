{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.xsession.window-manager.i3.applet.screensaver == "i3lock-fancy") {
    services.screen-locker = {
      enable = true;
      inactiveInterval = 10000;
      lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      xautolock.enable = true;
    };
  };
}
