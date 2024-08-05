{ pkgs, lib, config, ... }:

with lib; {
  config = mkIf (config.rain.xserver.desktop-manager == "xfce") {
    # Set xfce as desktop manager without its window manager
    services.xserver.desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };
    
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/desktop-managers/xfce.nix#L125
    # Newer versions of nixpkgs add support for this, but now I still have to manually define it here
    environment.systemPackages = mkIf (config.rain.system.sound != "disable") [
      pkgs.xfce.xfce4-volumed-pulse
    ];
  };
}
