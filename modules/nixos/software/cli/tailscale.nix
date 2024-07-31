{ lib, config, ... }:

{
  config = lib.mkIf config.mySystem.software.cli.enable {
    # Enable Tailscale service
    services.tailscale.enable = true;

    # Network settings
    networking.firewall.checkReversePath = "loose";
  };
}
