{ inputs, outputs, pkgs, ... }:

{
  imports = [ 
    outputs.nixosModules.rain
    # ../../modules/nixos/software
    # ../../modules/nixos/system
    # ../../modules/nixos/xserver

    # ../../modules/nixos/user.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
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
  environment.variables.JULIA_PKG_SERVER = "https://mirrors.nju.edu.cn/julia/";

  virtualisation.docker.enable = true;
}
