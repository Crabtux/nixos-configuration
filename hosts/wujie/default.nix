{ config, outputs, ... }:

{
  imports = [ 
    ../../profiles/nixos/desktop.nix
    ./hardware-configuration.nix
    outputs.nixosModules.rain
  ];

  networking.hostName = "wujie";

  # Configure the NVIDIA graphic card.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  boot.supportedFilesystems = [ "ntfs" ];

  # I don't have so much space in my home folder TAT
  rain.software.desktop.games.enable = false;

  # A temporary solution for the sound system issue
  # See also: https://github.com/NixOS/nixpkgs/issues/330685
  # boot.extraModprobeConfig =''
  #   options snd-hda-intel dmic_detect=0
  # '';
  boot.kernelPatches = [
    { name = "fix-1";
      patch =  builtins.fetchurl {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7";
        sha256 = "sha256:1y5nv1vgk73aa9hkjjd94wyd4akf07jv2znhw8jw29rj25dbab0q";
      };
    }
    { name = "fix-2";
      patch = builtins.fetchurl {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34";
        sha256 = "sha256:14xb6nmsyxap899mg9ck65zlbkvhyi8xkq7h8bfrv4052vi414yb";
      };
    }
  ];

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
        Option "PreferredMode" "2560x1440"
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
