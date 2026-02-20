{ lib, pkgs, inputs, ... }:

{
  imports = [
    ../../profiles/home-manager/desktop.nix
  ];

  rain.home.xsession.window-manager.i3 = {
    enable = true;
    applet = {
      app-menu = "rofi";
      bar = "polybar";
      compositor = "picom";
      screensaver = "i3lock-fancy";
    };
  };

  rain.home.wayland.hyprland.enable = true;

  # Xfce4 DPI settings (really useful)
  # xfconf.settings = {
  #   xsettings = {
  #     "Xft/DPI" = 160;

  #     "Xft/Antialias" = 1;
  #     "Xft/Hinting" = 1;
  #     "Xft/Hintstyle" = "hintfull";
  #     "Xft/RGBA" = "rgb";

  #     "Net/ThemeName" = "rose-pine";
  #     "Net/IconThemeName" = "rose-pine";
  #   };
  # };
  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    xwayland {
      force_zero_scaling = true
    }

    misc {
      focus_on_activate = false
    }
  '';

  # 核心修复：显式映射接口到对应的后端
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

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

  # 声明 Qt 配置
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "qt5ct"; 
  };

  home.packages = with pkgs; [
    qt6Packages.qt6ct
  ];

  services.hypridle.enable = lib.mkForce false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
