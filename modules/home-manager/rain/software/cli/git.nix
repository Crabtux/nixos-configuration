{ config, lib, ... }:

{
  config = lib.mkIf config.rain.home.software.cli.enable {
    programs.git = {
      enable = true;
      userName = "Crabtux";
      userEmail = "yue2002113@gmail.com";
      # attributes = [
      #   "http.proxy=127.0.0.1:7890"
      #   "https.proxy=127.0.0.1:7890"
      # ];
    };
  };
}
