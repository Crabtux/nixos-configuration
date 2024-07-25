{ lib, ... }:

with lib; {
  imports = [
    ./i3wm.nix
  ];

  options = {
    mySystem.xserver.window-manager = mkOption {
      type = types.enum ["disable" "i3"];
      default = "disable";
      description = "Choose window manager";
    };
  };
}
