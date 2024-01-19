{ config, pkgs, lib, ... }:

{
  services.v2ray.enable = true;

  services.v2ray.config = {
    # Warning: This is very impure! Considering other ways to solve it!
    # log = {
    #   loglevel = "warning";
    #   access = "/tmp/log/xray/access.log";
    #   error = "/tmp/log/xray/error.log";
    # };

    inbounds = [
      {
        tag = "HTTP Proxy";
        port = 10809;
        listen = "127.0.0.1";
        protocol = "http";
      }
      {
        tag = "Socks Proxy";
        port = 10810;
        listen = "127.0.0.1";
        protocol = "socks";
      }
    ];

    outbounds = [
      {
        tag = "Tailscale HTTP Proxy";
        protocol = "http";
        settings.servers = [
          {
            port = 6666;
            address = "ladder";
          }
        ];
      }
      {
        tag = "Tailscale Socks Proxy";
        protocol = "socks";
        settings.servers = [
          {
            port = 6667;
            address = "ladder";
          }
        ];
      }
      {
        tag = "direct";
        protocol = "freedom";
      }
      {
        tag = "blocked";
        protocol = "blackhole";
      }
    ];

    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        {
            type = "field";
            domain = [
                "geosite:category-ads-all"
            ];
            outboundTag = "blocked";
        }
        {
            type = "field";
            domain = [
                "geosite:cn"
                "geosite:geolocation-cn"
            ];
            outboundTag = "direct";
        }
        {
            type = "field";
            network = "tcp";
            outboundTag = "Tailscale HTTP Proxy";
        }
        {
            type = "field";
            network = "udp";
            outboundTag = "Tailscale Socks Proxy";
        }
      ];
    };
  };
}
