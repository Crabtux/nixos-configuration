{ pkgs, config, lib, ... }:

let
  cfg = config.rain.system.boot.loader;
in with lib; {
  options = {
    rain.system.boot.loader = mkOption {
      type = types.enum ["grub2"];
      default = "grub2";
      description = "Choose bootloader to use";
    };
  };

  config = mkIf (cfg == "grub2") {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      splashImage = null;
      backgroundColor = "#1e1e2e";
      theme = pkgs.stdenv.mkDerivation {
        pname = "catppuccin-grub2";
        version = "v0.1";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "grub";
          rev = "main";
          hash = "sha256-jgM22pvCQvb0bjQQXoiqGMgScR9AgCK3OfDF5Ud+/mk=";
        };
        installPhase = ''
          cp -r $src/src/catppuccin-mocha-grub-theme $out
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
}
