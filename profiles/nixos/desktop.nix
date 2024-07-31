{ inputs, outputs, pkgs, ... }:

{
  imports = [ 
    ../../modules/nixos/software
    ../../modules/nixos/system
    ../../modules/nixos/xserver

    ../../modules/nixos/user.nix
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

  mySystem = {
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
      network.enable = true;
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
  # environment.sessionVariables.http_proxy = [ "127.0.0.1:7890" ];
  # environment.sessionVariables.https_proxy = [ "127.0.0.1:7890" ];

  virtualisation.docker.enable = true;
}
