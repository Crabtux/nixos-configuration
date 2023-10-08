{ config, pkgs, lib, ... }:

let
  vars = import ./vars.nix pkgs;
in {
  programs.rofi.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    fadeSteps = [
      0.1
      0.1
    ];
  };

  services.polybar = {
    enable = true;
    config = vars.polybar-config + /docky/config.ini;
    script = ''
      # Terminate already running bar instances
      ${pkgs.psmisc}/bin/killall -q .polybar-wrapper
      
      # Wait until the processes have been shut down
      # while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
      
      # Launch the bar
      if type "polybar"; then
        for m in $(polybar -m | ${pkgs.coreutils}/bin/cut -d ':' -f 1); do
          MONITOR=$m polybar -q top &
          MONITOR=$m polybar -q bottom &
        done
      else
        polybar --reload top &
        polybar --reload bottom &
      fi
    '';
  };

  systemd.user.services.polybar = {
    Unit.After = [ "graphical-session.target" ];
    Unit.Wants = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Set up i3lock-fancy with xautolock as screensaver
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    xautolock.enable = true;
  };

  # gtk = {
  #   enable = true;

  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };

  #   theme = {
  #     name = "palenight";
  #     package = pkgs.palenight-theme;
  #   };

  #   cursorTheme = {
  #     name = "Numix-Cursor";
  #     package = pkgs.numix-cursor-theme;
  #   };

  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #   gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };
  # };

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
          "${modifier}+d" = "exec --no-startup-id rofi -no-config -no-lazy-grab -show drun -modi drun -theme ${vars.polybar-config}/docky/scripts/rofi/launcher.rasi";
        };
      startup = 
        [
          { command = "nitrogen --restore"; always = false; }
          { command = "picom"; always = false; }
          { command = "firefox"; always = false; }
          { command = "qq"; always = false; }
          { command = "telegram-desktop"; always = false; }
          { command = "thunderbird"; always = false; }
          { command = "clash"; always = false; }
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
