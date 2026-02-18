{ lib, config, ... }:

with lib; {
  imports = [
    ./compositor
    ./display-manager
  ];

  options.rain.wayland = {
    enable = mkEnableOption "wayland stack";
    compositor = mkOption {
      type = types.enum [ "disable" "sway" "hyprland" ];
      default = "disable";
      description = "Choose Wayland compositor";
    };
    display-manager = mkOption {
      type = types.enum [ "disable" "sddm" ];
      default = "disable";
      description = "Choose Wayland display manager";
    };
  };

  config = mkIf config.rain.wayland.enable {
    # Needed by many Wayland compositors for auth prompts.
    security.polkit.enable = true;
  };
}
