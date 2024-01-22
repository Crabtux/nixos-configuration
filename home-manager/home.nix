# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }: 

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../modules/home-manager/software/fish.nix
    ../modules/home-manager/software/git.nix
    ../modules/home-manager/software/vscode.nix
    ../modules/home-manager/software/firefox.nix

    ../modules/home-manager/xsession
  ];

  home = {
    username = "crabtux";
    homeDirectory = "/home/crabtux";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tdesktop
    neofetch
    clash-meta
    thunderbird
    nitrogen
    remmina
    anki
    wireshark
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
