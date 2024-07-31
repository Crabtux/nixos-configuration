{ lib, config, ... }:

with lib; {
  config = mkIf config.rain.system.bluetooth.enable {
    # Set Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
