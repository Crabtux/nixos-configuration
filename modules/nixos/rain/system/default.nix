{ lib, ... }:

with lib; {
  imports = [ 
    ./boot
    ./sound

    ./bluetooth.nix
    ./fonts.nix
    ./i18n.nix
    ./network.nix
  ];

  options = {
    rain.system = {
      bluetooth.enable = lib.mkEnableOption "bluetooth";
      i18n.enable = lib.mkEnableOption "i18n";
      fonts.enable = lib.mkEnableOption "fonts";
    };
  };
}
