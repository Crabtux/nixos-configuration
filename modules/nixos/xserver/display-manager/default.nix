{ lib, ... }:

with lib; {
  imports = [
    ./lightdm.nix
    ./gdm.nix
  ];

  options = {
    mySystem.xserver.display-manager = mkOption {
      type = types.enum ["disable" "gdm" "lightdm"];
      default = "disable";
      description = "Choose display manager";
    };
  };
}
