{ pkgs, ... }:

{
  imports = [
    ../../profiles/home-manager/desktop.nix
  ];

  rain.home.xsession.window-manager.i3 = {
    enable = true;
    applet = {
      app-menu = "rofi";
      bar = "polybar";
      compositor = "picom";
      screensaver = "i3lock-fancy";
    };
  };
}
