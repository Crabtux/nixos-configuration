{ lib, config, ... }:

with lib; let
  cfg = config.rain.system.network;
in {
  options = {
    rain.system.network = {
      enable = mkEnableOption "system network";
      proxy = {
        env.enable = mkEnableOption "proxy environment variables";
        nix.enable = mkEnableOption "nix proxy";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.enableIPv6 = true;
    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = true;

    services.resolved = {
      enable = true;
      dnssec = "false";
    };

    environment.sessionVariables = mkIf cfg.proxy.env.enable {
      http_proxy = [ "127.0.0.1:7890" ];
      https_proxy = [ "127.0.0.1:7890" ];
    };

    systemd.services.nix-daemon.environment = mkIf cfg.proxy.nix.enable {
      http_proxy = "127.0.0.1:7890";
      https_proxy = "127.0.0.1:7890";
    };
  };
}
