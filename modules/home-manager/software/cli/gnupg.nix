{ lib, config, ... }:

{
  config = lib.mkIf config.mySystem.home-manager.software.cli.enable {
    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
