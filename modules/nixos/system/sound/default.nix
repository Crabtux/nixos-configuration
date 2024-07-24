{ config, pkgs, lib, ... }:

{
  imports = [
    ./mpd.nix
    ./pulseaudio.nix
    ./pipewire.nix
  ];

  options = {
    mySystem.sound = {
      # enable = lib.mkOption {
      #   type = lib.types.bool;
      #   default = false;
      #   description = "Enable sound configuration";
      # };

      pipewire.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use pipewire as sound server";
      };

      pulseaudio.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use pulseaudio as sound server";
      };

      mpd.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use mpd";
      };
    };
  };
}
