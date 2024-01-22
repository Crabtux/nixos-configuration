{ ... }:

{
  imports = [
    ./mpd.nix
    ./pulseaudio.nix
  ];

  sound.enable = true;
}
