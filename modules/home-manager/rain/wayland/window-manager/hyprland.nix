{ config, lib, pkgs, ... }:

let
  cfg = config.rain.home.wayland.hyprland;
in with lib; {
  options = {
    rain.home.wayland.hyprland = {
      enable = mkEnableOption "hyprland";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
      hyprlock
      wl-clipboard
    ];

    programs.waybar.enable = true;
    programs.wofi.enable = true;

    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = /home/crabtux/Pictures/wallpaper1.png
      wallpaper = /home/crabtux/Pictures/wallpaper1.png
    '';
    xdg.configFile."waybar/config".text = ''
      [
        {
          "layer": "top",
          "position": "top",
          "modules-left": ["hyprland/workspaces"],
          "modules-right": ["clock"]
        },
        {
          "layer": "top",
          "position": "bottom",
          "modules-right": ["tray"]
        }
      ]
    '';

    wayland.windowManager.hyprland = {
      enable = true;

      # Recommended when launching Hyprland via UWSM on NixOS.
      systemd.enable = false;

      extraConfig = ''
        $mod = SUPER

        exec-once = fcitx5 -d
        exec-once = hyprpaper
        exec-once = waybar

        input {
          kb_layout = us
        }

        general {
          gaps_in = 9
          gaps_out = 0
          border_size = 0
          layout = dwindle
        }

        animations {
          enabled = true
        }

        xwayland {
          force_zero_scaling = true
        }

        # Upscale XWayland apps after disabling compositor scaling.
        env = GDK_SCALE,2
        env = GDK_DPI_SCALE,0.5
        env = QT_SCALE_FACTOR,2
        env = QT_AUTO_SCREEN_SCALE_FACTOR,0

        bind = $mod, D, exec, wofi --show drun
        bind = $mod SHIFT, E, exit
        bind = CTRL $mod, L, exec, hyprlock
        bind = $mod, Return, exec, wezterm
        bind = $mod SHIFT, Q, killactive
        bind = $mod SHIFT, R, exec, hyprctl reload
        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6
        bind = $mod, 7, workspace, 7
        bind = $mod, 8, workspace, 8
        bind = $mod, 9, workspace, 9
        bind = $mod, 0, workspace, 10
        bind = $mod SHIFT, 1, movetoworkspace, 1
        bind = $mod SHIFT, 2, movetoworkspace, 2
        bind = $mod SHIFT, 3, movetoworkspace, 3
        bind = $mod SHIFT, 4, movetoworkspace, 4
        bind = $mod SHIFT, 5, movetoworkspace, 5
        bind = $mod SHIFT, 6, movetoworkspace, 6
        bind = $mod SHIFT, 7, movetoworkspace, 7
        bind = $mod SHIFT, 8, movetoworkspace, 8
        bind = $mod SHIFT, 9, movetoworkspace, 9
        bind = $mod SHIFT, 0, movetoworkspace, 10

        # App autostart (mirrors i3)
        exec-once = firefox
        exec-once = qq
        exec-once = telegram-desktop

        # Workspace assignments (best-effort port from i3)
        windowrulev2 = workspace 2, class:^(Code)$
        windowrulev2 = workspace 7, class:^(QQ)$
        windowrulev2 = workspace 8, class:^(TelegramDesktop)$
        windowrulev2 = workspace 9, class:^(thunderbird)$
        windowrulev2 = workspace 10, class:^(firefox)$

        # Floating rules (best-effort port from i3)
        windowrulev2 = float, class:^(QQ)$, title:^(图片查看器|视频播放器|群文件|群公告)$
        windowrulev2 = float, class:^(wemeetapp)$
      '';
    };
  };
}
