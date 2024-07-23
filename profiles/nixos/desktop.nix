{ inputs, outputs, pkgs, ... }:

{
  imports = [ 
    ../../modules/nixos/xserver

    ../../modules/nixos/software

    ../../modules/nixos/system/sound
    ../../modules/nixos/system/bluetooth.nix
    ../../modules/nixos/system/fonts.nix
    ../../modules/nixos/system/i18n.nix

    ../../modules/nixos/network.nix
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

  # For printing to PDF
  services.printing.enable = true;

  # Used by VS Code
  services.gnome.gnome-keyring.enable = true;

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
