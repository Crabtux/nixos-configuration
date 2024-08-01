{ lib, config, ... }:

let
  cfg = config.rain.system.bluetooth;
in with lib; {
  options = {
    rain.system.bluetooth = {
      enable = mkEnableOption "system bluetooth";
    };
  };

  config = mkIf cfg.enable {
    # Set Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
