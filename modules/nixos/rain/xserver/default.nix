{ ... }:

{
  imports = [
    ./display-manager
    ./desktop-manager
    ./window-manager
  ];

  services.xserver = {
    enable = true;
    dpi = 144;
    layout = "us";
    libinput.enable = true;
  };
}
