# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, outputs, ... }:

{
  imports =
    [ 
      ../../profiles/nixos/desktop.nix
      ./hardware-configuration.nix
      outputs.nixosModules.rain
    ];

  networking.hostName = "TX-Air";

  # Configure the NVIDIA graphic card.
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Thank you, Gemini 3 Pro!
  # An workaround used to fix an issue of screen freezing on idle with amdgpu
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';

  # Thank you again, Gemini 3 Pro!
  # 另一个 workaround，用来修开机卡顿 36s 的问题
  # See also: https://www.bilibili.com/opus/1104887054270988297
  boot.kernelParams = [
    "initcall_blacklist=acpi_gpio_handle_deferred_request_irqs"
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}

