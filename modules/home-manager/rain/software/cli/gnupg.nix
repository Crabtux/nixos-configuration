{ lib, config, ... }:

{
  config = lib.mkIf config.rain.home.software.cli.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
