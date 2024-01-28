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
    ../../modules/home-manager/software/direnv.nix
    ../../modules/home-manager/software/fish.nix
    ../../modules/home-manager/software/git.nix
    ../../modules/home-manager/software/tmux.nix
    ../../modules/home-manager/software/neovim
  ];

  targets.genericLinux.enable = true;

  home = {
    username = "crabtux";
    homeDirectory = "/home/crabtux";
  };

  home.packages = with pkgs; [
    nil
    tmux
    neofetch
    clash-meta
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
