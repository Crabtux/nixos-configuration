{ config, pkgs, lib, ... }:

{
  programs.rofi.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    fadeSteps = [
      0.1
      0.1
    ];
  };

  # A simple derivation as a wrapper
  services.polybar = let
    polybar-config = pkgs.stdenv.mkDerivation {
      name = "polybar-config";
      src = ./.;
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        mkdir -p $out
        cp -r $src/docky/ $out
      '';
    };
  in
    {
      enable = true;
      config = polybar-config + /docky/config.ini;
      script = builtins.readFile ./launch.sh;
    };
    
  systemd.user.services.polybar = {
    Install.WantedBy = [ "graphical-session.target" "tray.target" ];
  };

  # Set up i3lock-fancy with xautolock as screensaver (instead of the bullshit default xfce4-screensaver)
  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    xautolock = {
      enable = true;
    };
  };

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
          "${modifier}+d" = "exec --no-startup-id /home/crabtux/.config/polybar/docky/scripts/launcher.sh";
        };
      startup = [
        { command = "nitrogen --restore"; always = false; }
        { command = "picom --config ~crabtux/.config/picom/picom.conf"; always = false; }
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
      ];
    };
  };
}
