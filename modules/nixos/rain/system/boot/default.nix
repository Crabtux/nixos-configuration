{ lib, config, ... }:

{
  imports = [
    ./grub.nix
  ];

  options = {
    rain.system.boot.loader = lib.mkOption {
      type = lib.types.enum ["grub2"];
      default = "grub2";
      description = "Choose bootloader to use";
    };
  };
}
