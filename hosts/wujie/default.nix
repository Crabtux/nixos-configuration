{ config, pkgs, ... }:

{
  imports = [ 
    ../../profiles/nixos/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "wujie";

  # Configure the NVIDIA graphic card.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  boot.supportedFilesystems = [ "ntfs" ];

  # A temporary solution for the sound system issue
  # See also: https://github.com/NixOS/nixpkgs/issues/330685
  boot.extraModprobeConfig =''
    options snd-hda-intel dmic_detect=0
  '';

  # Force to use the ifname '0' to solve a problem.
  boot.kernelParams = [
    "net.ifnames=0"
    "biosdevname=0"
  ];

  # wujie's multiple monitor setup
  # Should be moved to `profiles` directory later
  services.xserver.xrandrHeads = [
    {
      output = "eDP-1";
      primary = true;
      monitorConfig = ''
        Option "PreferredMode" "2560x1600"
      '';
    }
    {
      output = "HDMI-1";
      monitorConfig = ''
        Option "PreferredMode" "3840x2160"
      '';
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
