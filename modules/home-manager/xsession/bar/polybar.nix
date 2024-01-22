{ pkgs, vars, ... }:

{
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
}
