{ ... }:

{
  imports = [
    # applets used in window manager
    ./bar
    ./app-menu
    ./compositor
    ./screensaver

    # window managers
    ./i3wm.nix
  ];
}
