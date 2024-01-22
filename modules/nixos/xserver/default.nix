{ ... }:

{
  imports = [
    ./display-manager
    ./desktop-manager
    ./window-manager
    ./libinput.nix
  ];

  services.xserver = {
    enable = true;
    dpi = 144;
    layout = "us";
  };
}
