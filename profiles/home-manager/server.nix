{ pkgs, outputs, ... }: 

{
  imports = [
    outputs.homeManagerModules.rain
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
