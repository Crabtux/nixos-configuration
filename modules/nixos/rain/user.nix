{ lib, config, pkgs, ... }:

let
  cfg = config.rain.user;
in {
  options = {
    rain.user = {
      crabtux.enable = lib.mkEnableOption "user crabtux";
    };
  };

  config = lib.mkIf cfg.crabtux.enable {
    users.defaultUserShell = pkgs.fish;

    users.users.crabtux = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" "docker" ]; 
    };
  };
}
