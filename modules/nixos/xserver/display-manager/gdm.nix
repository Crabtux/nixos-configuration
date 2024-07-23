{ ... }:

{
  services.xserver.displayManager = {
    gdm = {
      enable = true;
      # background = ./lightdm-background.jpg;
      # extraConfig = ''
      #   xserver-command=X -dpi 144
      # '';
      # greeters.slick = {
      #   enable = true;
      #   extraConfig = ''
      #     enable-hidpi=on
      #     show-power=true
      #     high-contrast=true
      #   '';
      # };
    };
    defaultSession = "xfce+i3";
  };
}
