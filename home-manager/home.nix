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
    ./xserver/config.nix
  ];

  # TODO: Set your username
  home = {
    username = "crabtux";
    homeDirectory = "/home/crabtux";
  };

  systemd.user.targets.tray = {
    Install.WantedBy = [ "graphical-session.target" ];
    Unit = {
      Description = "Home Manager System Tray";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.firefox.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch -v";
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
    # attributes = [
    #   "http.proxy=127.0.0.1:7890"
    #   "https.proxy=127.0.0.1:7890"
    # ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      ms-vscode-remote.remote-ssh

      github.copilot

      vscodevim.vim

      mhutchie.git-graph
      dracula-theme.theme-dracula
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "language-julia";
        publisher = "julialang";
        version = "1.65.2";
        sha256 = "sha256-CRAt9I4Jzg60YzyxtZZU8UF0JMnV8mGgsUmVN0adBv4=";
      }
    ];
  };

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
