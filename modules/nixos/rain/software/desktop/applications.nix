{ config, lib, pkgs, ... }:

let
  cfg = config.rain.software.desktop.applications;
in with lib; {
  options = {
    rain.software.desktop.applications = {
      enable = mkEnableOption "desktop application";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # office
      unstable.qq
      libreoffice
      beebeep

      # video
      obs-studio

      # graphics
      gimp
    ];

    # Enable flatpak for all users
    services.flatpak.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      # 核心修复：显式映射接口到对应的后端
      config = {
        common = {
          # 默认优先使用 hyprland，找不到再用 gtk 后备
          default = [
            "hyprland"
            "gtk"
          ];
          # 明确指定把外观设置（深色模式等）的接口交给 gtk 处理
          "org.freedesktop.portal.Settings" = [
            "gtk"
          ];
        };
      };
    };

    qt = {
      enable = true;
      platformTheme = lib.mkForce "qt5ct"; 
    };

    # Used by VS Code
    services.gnome.gnome-keyring.enable = true;
  };
}
