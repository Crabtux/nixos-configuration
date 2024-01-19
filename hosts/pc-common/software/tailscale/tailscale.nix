{ config, pkgs, lib, ... }:

{
  # Enable Tailscale service
  services.tailscale.enable = true;

  # Network settings
  networking.firewall.checkReversePath = "loose";
}
