{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
}
