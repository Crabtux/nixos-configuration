{ pkgs, ... }:

{
  # Set up i3lock-fancy with xautolock as screensaver
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    xautolock.enable = true;
  };
}
