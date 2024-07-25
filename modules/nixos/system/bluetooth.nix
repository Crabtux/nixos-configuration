{ lib, config, ... }:

with lib; {
  config = mkIf config.mySystem.system.bluetooth.enable {
    # Set Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
