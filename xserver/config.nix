{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    dpi = 144;

    # Set up lightdm as displayManager
    displayManager = {
      lightdm = {
        enable = true;

        background = /home/crabtux/Downloads/test.jpg;

        extraConfig = ''
          xserver-command=X -dpi 144
        '';

        greeters.slick = {
          enable = true;
          extraConfig = ''
            enable-hidpi=on
            show-power=true
            high-contrast=true
          '';
        };
      };

      defaultSession = "xfce+i3";
    };

    # Set up xfce as desktopManager
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };

    # Set up i3-gaps as windowManager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };

    # Set up i3lock-fancy with xautolock as screensaver (instead of the bullshit default xfce4-screensaver)
    xautolock = {
      enable = true;
      locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      time = 10;
    };
  };
}
