{ pkgs, config, lib, ... }:

{
  config = lib.mkIf (config.rain.system.boot.loader == "grub2") {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
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
          hash = "sha256-e8XFWebd/GyX44WQI06Cx6sOduCZc5z7/YhweVQGMGY=";
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
