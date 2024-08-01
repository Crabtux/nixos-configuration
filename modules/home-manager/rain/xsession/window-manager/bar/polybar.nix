{ config, lib, pkgs, outputs, ... }:

let 
  polybar-config = outputs.packages.polybar-config;
  cfg = config.rain.home.xsession.window-manager.i3.applet.bar;
in with lib; {
  config = mkIf (cfg == "polybar") {
    services.polybar = {
      enable = true;
      config = polybar-config + /docky/config.ini;
      script = ''
        # Terminate already running bar instances
        ${pkgs.psmisc}/bin/killall -q .polybar-wrapper
        
        # Wait until the processes have been shut down
        while ${pkgs.procps}/bin/pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
  
        # Wait until i3 socket is ready
        while true; do
          ${pkgs.i3}/bin/i3 --get-socketpath > /dev/null
          if [ $? -eq 0 ]; then
            break
          else
            ${pkgs.coreutils}/bin/sleep 1
          fi
        done
        
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
  
    # Start with session
    systemd.user.services.polybar = {
      Unit.After = [ "graphical-session.target" ];
      Unit.Wants = [ "graphical-session.target" ];
      Install.WantedBy = [ "graphical-session.target" ];
    };
  
    systemd.user.targets.tray = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Home Manager System Tray";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };
    };
  };
}
