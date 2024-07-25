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

  mySystem.xserver.display-manager = "gdm";
  mySystem.system = {
    sound.pipewire.enable = true;
    bluetooth.enable = true;
    fonts.enable = true;
    i18n.enable = true;
    network.enable = true;
  };

  # For printing to PDF
  services.printing.enable = true;

  # Enable flatpak for all users
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # Set the default i3-sensible-terminal
  environment.sessionVariables.TERMINAL = [ "wezterm" ];
  environment.variables.JULIA_PKG_SERVER = "https://mirrors.nju.edu.cn/julia/";
  # environment.sessionVariables.http_proxy = [ "127.0.0.1:7890" ];
  # environment.sessionVariables.https_proxy = [ "127.0.0.1:7890" ];

  virtualisation.docker.enable = true;
}
