{ config, lib, pkgs, ... }:

let
  cfg = config.rain.home.wayland.sway;
in with lib; {
  options = {
    rain.home.wayland.sway = {
      enable = mkEnableOption "sway";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      swaylock
    ];

    programs.waybar.enable = true;
    programs.wofi.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec {
        bars = [ { command = "waybar"; } ];
        defaultWorkspace = "workspace number 1";
        gaps.inner = 9;
        modifier = "Mod4";
        terminal = "wezterm";
        window.titlebar = false;
        keybindings = lib.mkOptionDefault {
          "Ctrl+${modifier}+l" = "exec swaylock -f -c 000000";
          "${modifier}+Shift+e" = "exec swaymsg exit";
          "${modifier}+d" = "exec wofi --show drun";
        };
        startup = [
          { command = "fcitx5 -d"; always = true; }
          { command = "swaybg -i /home/crabtux/Pictures/wallpaper1.png -m fill"; always = true; }

          { command = "firefox"; always = false; }
          { command = "qq"; always = false; }
          { command = "telegram-desktop"; always = false; }
        ];
        assigns = {
          "number 1: terminal" = [{ class = "non-existent"; }];
          "number 2: Code" = [{ class = "Code"; }];
          "number 7: QQ" = [{ class = "QQ"; }];
          "number 8: TelegramDesktop" = [{ class = "TelegramDesktop"; }];
          "number 9: thunderbird" = [{ class = "thunderbird"; }];
          "number 10: firefox" = [{ class = "firefox"; }];
        };
        floating.criteria = [
          {
            class = "QQ";
            title = "图片查看器|视频播放器|群文件|群公告";
          }
          {
            class = "wemeetapp";
          }
        ];
      };
      extraConfig = ''
        # set primary Rosé Pine colorscheme colors
        set $base           #191724
        set $surface        #1f1d2e
        set $overlay        #26233a
        set $muted          #6e6a86
        set $subtle         #908caa
        set $text           #e0def4
        set $love           #eb6f92
        set $gold           #f6c177
        set $rose           #ebbcba
        set $pine           #31748f
        set $foam           #9ccfd8
        set $iris           #c4a7e7
        set $highlightlow   #21202e
        set $highlightmed   #403d52
        set $highlighthigh  #524f67
        
        # Teming border and Windows --------------
        # target                 title     bg    text   indicator  border
        client.focused           $rose     $base $text  $rose      $rose
        client.focused_inactive  $text     $base $text  $subtle    $surface
        client.unfocused         $text     $base $text  $overlay   $overlay
        client.urgent            $text     $base $text  $love      $love
        client.placeholder       $base     $base $text  $overlay   $overlay
        client.background        $base
      '';
    };
  };
}
