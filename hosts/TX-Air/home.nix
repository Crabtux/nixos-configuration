{ inputs, ... }:

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

  rain.home.wayland.hyprland.enable = true;

  # Xfce4 DPI settings (really useful)
  xfconf.settings = {
    xsettings = {
      "Xft/DPI" = 160;

      "Xft/Antialias" = 1;
      "Xft/Hinting" = 1;
      "Xft/Hintstyle" = "hintfull";
      "Xft/RGBA" = "rgb";

      "Net/ThemeName" = "rose-pine";
      "Net/IconThemeName" = "rose-pine";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
