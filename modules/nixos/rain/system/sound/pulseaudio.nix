{ config, pkgs, lib, ... }:

let
  cfg = config.rain.system.sound.pulseaudio;
in with lib; {
  options = {
    rain.system.sound.pulseaudio = {
      enable = mkEnableOption "pulseaudio";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.pulseaudio = true;

    environment.systemPackages = with pkgs; [
      pa_applet
    ];

    hardware.pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    sound.enable = true;
  };
}
