{ ... }:

{
  imports = [
    ./display-manager
    ./desktop-manager
    ./window-manager
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
  };
}
