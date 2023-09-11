{ config, pkgs, lib, ... }:

{
  # Further configurations are defined in home-manager.
  services.xserver = {
    enable = true;
    dpi = 144;

    windowManager.i3.enable = true;

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
  };
}
