{ lib, outputs, ... }:

{
  imports = [ 
    outputs.nixosModules.rain
  ];

  nix.settings = {
    substituters = lib.mkForce [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org" ];
    experimental-features = [ "nix-command" "flakes" ];
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
      network = {
        enable = true;
        proxy = {
          env.enable = true;
          nix.enable = true;
        };
      };
    };

    software = {
      cli.enable = true;
      desktop = {
        applications.enable = true;
        games.enable = true;
        tools.enable = true;
      };
    };
  };

  # For printing to PDF
  services.printing.enable = true;

  # Set the default i3-sensible-terminal
  environment.sessionVariables.TERMINAL = [ "wezterm" ];

  virtualisation.docker.enable = true;
}
