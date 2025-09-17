{ lib, config, pkgs, ... }:

let
  cfg = config.rain.user;
in with lib; {
  options = {
    rain.user = {
      crabtux.enable = mkEnableOption "user crabtux";
    };
  };

  config = mkIf cfg.crabtux.enable {
    users.defaultUserShell = pkgs.fish;

    users.users.crabtux = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ]; 
    };

    nix.settings.trusted-users = [ "crabtux" ];
  };
}
