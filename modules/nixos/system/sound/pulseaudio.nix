{ config, pkgs, lib, ... }:

with lib; {
  config = mkIf config.mySystem.system.sound.pulseaudio.enable {
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
