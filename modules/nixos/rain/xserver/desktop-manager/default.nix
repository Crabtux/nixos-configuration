{ lib, ... }:

with lib; {
  imports = [
    ./xfce.nix
  ];

  options = {
    rain.xserver.desktop-manager = mkOption {
      type = types.enum ["disable" "xfce"];
      default = "disable";
      description = "Choose desktop manager";
    };
  };
}
