{ config, pkgs, lib, ... }:

{
  imports = [ 
    ./xserver/config.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  
  home.username = "crabtux";
  home.homeDirectory = "/home/crabtux";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    tdesktop
    neofetch
    clash
    thunderbird
    nitrogen
  ];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  programs.firefox.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch -v --impure";
      nixos-edit = "cd /etc/nixos; sudo vim /etc/nixos/configuration.nix; cd -;";
    };
    plugins = [
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "theme-toaster";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-toaster";
          rev = "master";
          sha256 = "sha256-phghheRBsPXmoVZTXr6RoR8zZl3gOFH9jmMioRYdBjE=";
        };
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Crabtux";
    userEmail = "yue2002113@gmail.com";
    attributes = [
      "http.proxy=127.0.0.1:7890"
      "https.proxy=127.0.0.1:7890"
    ];
  };
}
