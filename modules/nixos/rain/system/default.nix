{ lib, ... }:

with lib; {
  imports = [ 
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
      network.enable = lib.mkEnableOption "network";
    };
  };
}
