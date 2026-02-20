{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.rain.home.wayland.hyprland;
in with lib; {
  imports = [
    inputs.illogical-impulse.homeManagerModules.default
  ];

  options = {
    rain.home.wayland.hyprland = {
      enable = mkEnableOption "hyprland";
    };
  };

  config = mkIf cfg.enable {
    # Hyprland theme
    illogical-impulse = {
      # Enable the dotfiles suite
      enable = true;
    
      hyprland = {
        # Enable Wayland ozone
        ozoneWayland.enable = true;
      };
    };

    illogical-impulse.hyprland.monitor = [
      "eDP-1,preferred,auto,1.6"
      "eDP-2,2560x1600@165,auto,1.6"
    ];
  };
}
