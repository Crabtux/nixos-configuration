{ config, pkgs, ... }:

{
  imports = [ 
    ../../profiles/nixos/desktop.nix
    ./hardware-configuration.nix
  ];

  # 机器特定配置
  networking.hostName = "wujie";

  # Use grub2 as bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      theme = pkgs.stdenv.mkDerivation {
        pname = "touhou-grub2-theme";
        version = "v0.1";
        src = pkgs.fetchFromGitHub {
          owner = "13atm01";
          repo = "GRUB-Theme";
          rev = "master";
          hash = "sha256-ghsqg6sr9xCkdik24hNcITkiHVVmYzSVVHPTOHCM8oM=";
        };
        installPhase = ''
          cp -r 'Touhou Project/Touhou-project' $out
        '';
      };
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };

  # Configure the NVIDIA graphic card.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelPackages = pkgs.linuxPackages_6_1;

  # Use the kernel patch to make i915 work correctly.
  boot.kernelPatches = [{
    name = "patch-i915";
    patch = ./kernel_patch/i915.patch;
  }];

  # Force to use the ifname '0' to solve a problem.
  boot.kernelParams = [
    "net.ifnames=0"
    "biosdevname=0"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
