{ lib, config, pkgs, ... }:

{
  config = lib.mkIf config.rain.home.software.desktop.enable {
    # GTK Theme
    gtk = {
      enable = true;
      theme = {
        name = "rose-pine-gtk-theme";
        package = pkgs.rose-pine-gtk-theme;
      };
      iconTheme = {
        name = "rose-pine-icon-theme";
        package = pkgs.rose-pine-icon-theme;
      };
    };
  };
}
