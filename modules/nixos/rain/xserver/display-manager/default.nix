{ lib, ... }:

with lib; {
  imports = [
    ./lightdm.nix
    ./gdm.nix
    ./sddm.nix
  ];

  options = {
    rain.xserver.display-manager = mkOption {
      type = types.enum ["disable" "gdm" "lightdm" "sddm"];
      default = "disable";
      description = "Choose display manager";
    };
  };

  config = {
    services.xserver.displayManager.sessionCommands = "nitrogen --restore";
  };
}
