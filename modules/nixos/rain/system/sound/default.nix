{ config, pkgs, lib, ... }:

{
  imports = [
    ./mpd.nix
    ./pulseaudio.nix
    ./pipewire.nix
  ];

  options = {
    rain.system.sound = {
      # enable = lib.mkEnableOption "sound";
      pipewire.enable = lib.mkEnableOption "pipewire";
      pulseaudio.enable = lib.mkEnableOption "pulseaudio";
      mpd.enable = lib.mkEnableOption "mpd";
    };
  };
}
