{ config, lib, outputs, ... }:

let
  polybar-config = outputs.packages.polybar-config;
  cfg = config.rain.home.xsession.window-manager.i3;
in with lib; {
  imports = [
    ./app-menu
    ./bar
    ./compositor
    ./screensaver
  ];

  options = {
    rain.home.xsession.window-manager.i3 = {
      enable = mkEnableOption "i3wm";
      applet = {
        app-menu = mkOption {
          type = types.enum ["rofi"];
          default = "disable";
          description = "Choose app-menu applet for i3wm";
        };

        bar = mkOption {
          type = types.enum ["polybar"];
          default = "disable";
          description = "Choose status bar for i3wm";
        };

        compositor = mkOption {
          type = types.enum ["picom"];
          default = "disable";
          description = "Choose compositor for i3wm";
        };

        screensaver = mkOption {
          type = types.enum ["i3lock-fancy"];
          default = "disable";
          description = "Choose screensaver for i3wm";
        };
      };
    };
  };

  config = {
    xsession.windowManager.i3 = mkIf cfg.enable {
      enable = true;
      config = {
        bars = [];
        gaps.inner = 9;
        modifier = "Mod4";
        keybindings = 
          let
            modifier = config.xsession.windowManager.i3.config.modifier;
          in lib.mkOptionDefault {
            "Ctrl+${modifier}+l" = "exec i3lock-fancy";
            "${modifier}+Shift+e" = "exec xfce4-session-logout";
            "${modifier}+d" = "exec --no-startup-id rofi -no-config -no-lazy-grab -show drun -modi drun -theme ${polybar-config}/docky/scripts/rofi/launcher.rasi";
          };
        startup = 
          [
            { command = "picom"; always = false; }
            { command = "firefox"; always = false; }
            { command = "qq"; always = false; }
            { command = "telegram-desktop"; always = false; }
            { command = "thunderbird"; always = false; }
            { command = "clash-meta -d /home/crabtux/.config/clash/"; always = false; }
          ];
        assigns = {
          "number 1: terminal" = [{ class = "non-existent"; }];
          "number 2: Code" = [{ class = "Code"; }];
          "number 7: QQ" = [{ class = "QQ"; }];
          "number 8: TelegramDesktop" = [{ class = "TelegramDesktop"; }];
          "number 9: thunderbird" = [{ class = "thunderbird"; }];
          "number 10: firefox" = [{ class = "firefox"; }];
        };
        defaultWorkspace = "workspace number 1";
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
