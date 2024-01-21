{ ... }:

{
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
}
