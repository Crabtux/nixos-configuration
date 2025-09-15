{ lib, outputs, pkgs, ... }:

{
  imports = [ 
    outputs.nixosModules.rain
  ];

  nix = {
    package = pkgs.unstable.nixVersions.latest;
    settings = {
      substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
      outputs.overlays.modifications
    ];
    config.allowUnfree = true;
  };

  rain = {
    xserver = {
      display-manager = "sddm";
      desktop-manager = "xfce";
      window-manager = "i3";
    };

    system = {
      sound.pipewire.enable = true;
      bluetooth.enable = true;
      fonts.enable = true;
      i18n.enable = true;
      boot.loader = "grub2";
      virt = {
        enable = true;
        virt-manager.enable = true;
        docker.enable = true;
        wine.enable = true;
      };
      network = {
        enable = true;
        proxy = {
          enable = true;
          env.enable = true;
          nix.enable = true;
        };
      };
    };

    software = {
      cli.enable = true;
      desktop = {
        applications.enable = true;
        games.enable = lib.mkDefault true;
        tools.enable = true;
      };
    };

    user.crabtux.enable = true;
  };

  # Enable printing to PDF
  services.printing.enable = true;
}
