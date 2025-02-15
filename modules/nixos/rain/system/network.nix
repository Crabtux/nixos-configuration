{ lib, config, ... }:

let
  cfg = config.rain.system.network;
in with lib; {
  options = {
    rain.system.network = {
      enable = mkEnableOption "system network";
      tailscale.enable = mkEnableOption "tailscale";
      proxy = {
        enable = mkEnableOption "proxy";
        env.enable = mkEnableOption "proxy environment variables";
        nix.enable = mkEnableOption "nix daemon proxy";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.enableIPv6 = true;
    networking.useDHCP = mkDefault true;
    networking.networkmanager.enable = true;

    services.resolved = {
      enable = true;
      dnssec = "false";
    };

    services.tailscale.enable = mkIf cfg.tailscale.enable true;
    networking.firewall.checkReversePath = mkIf cfg.tailscale.enable "loose";

    services.mihomo = mkIf cfg.proxy.enable {
      enable = true;
      configFile = "/home/crabtux/.config/clash/config.yaml";
    };

    environment.sessionVariables = mkIf (cfg.proxy.enable && cfg.proxy.env.enable) {
      http_proxy = [ "127.0.0.1:7890" ];
      https_proxy = [ "127.0.0.1:7890" ];
    };

    systemd.services.nix-daemon.environment = mkIf (cfg.proxy.enable && cfg.proxy.env.enable) {
      http_proxy = "127.0.0.1:7890";
      https_proxy = "127.0.0.1:7890";
    };
  };
}
