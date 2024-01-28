{ pkgs, ... }:

{
  nixpkgs.config.pulseaudio = true;

  environment.systemPackages = with pkgs; [
    pa_applet
  ];

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    # For compatability of mpd
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  };
}
