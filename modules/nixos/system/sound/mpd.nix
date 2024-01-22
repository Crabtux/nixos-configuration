{ ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/Music";
    user = "mpd";

    # Extra configurations
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PULSEAUDIO"
        server "127.0.0.1"
      }
    '';
  };
}
