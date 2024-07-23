{ pkgs, ... }:

{
  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  # GUI Utils
  environment.systemPackages = with pkgs; [
    pavucontrol
    pa_applet
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
}
