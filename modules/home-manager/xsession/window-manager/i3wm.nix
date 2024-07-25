{ config, lib, outputs, ... }:

let
  polybar-config = outputs.packages.polybar-config;
in {
  xsession.windowManager.i3 = {
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
          { command = "nitrogen --restore"; always = false; }
          { command = "picom"; always = false; }
          { command = "firefox"; always = false; }
          { command = "qq"; always = false; }
          { command = "telegram-desktop"; always = false; }
          { command = "thunderbird"; always = false; }
          { command = "clash-meta"; always = false; }
          { command = "pa-applet"; always = false; }
        ];
      assigns = {
        "number 1: terminal" = [{ class = "non-existent"; }];
        "number 2: Code" = [{ class = "Code"; }];
        "number 7: QQ" = [{ class = "QQ"; }];
        "number 8: TelegramDesktop" = [{ class = "TelegramDesktop"; }];
        "number 9: thunderbird" = [{ class = "thunderbird"; }];
        "number 10: firefox" = [{ class = "firefox"; }];
      };
      colors.focused = {
        background = "#ffb6c1";
        border = "#ffb6c1";
        childBorder = "#ffb6c1";
        indicator = "#2e9ef4";
        text = "#ffffff";
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
  };
}
