{ config, pkgs, lib, ... }:

{
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
  ];

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

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = [];
      gaps.inner = 9;
      modifier = "Mod4";
      keybindings = 
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "Ctrl+${modifier}+l" = "exec i3lock-fancy";
          "${modifier}+Shift+e" = "exec xfce4-session-logout";
          "${modifier}+d" = "exec --no-startup-id /home/crabtux/.config/polybar/docky/scripts/launcher.sh";
        };
      startup = [
        { command = "nitrogen --restore"; always = false; }
        { command = "picom --config ~crabtux/.config/picom/picom.conf"; always = false; }
        { command = "MONITOR=\"eDP-1\" /home/crabtux/.config/polybar/launch.sh --docky"; always = false; }
        { command = "firefox"; always = false; }
        { command = "qq"; always = false; }
        { command = "telegram-desktop"; always = false; }
        { command = "thunderbird"; always = false; }
        { command = "clash"; always = false; }
      ];
      assigns = {
        "number 1: terminal" = [{ class = "non-existent"; }];
        "number 2: Code" = [{ class = "Code"; }];
        "number 7: QQ" = [{ class = "QQ"; }];
        "number 8: TelegramDesktop" = [{ class = "TelegramDesktop"; }];
        "number 9: thunderbird" = [{ class = "thunderbird"; }];
        "number 10: firefox" = [{ class = "firefox"; }];
      };
      colors.focused = {
        background = "#ffb6c1";
        border = "#ffb6c1";
        childBorder = "#ffb6c1";
        indicator = "#2e9ef4";
        text = "#ffffff";
      };
      defaultWorkspace = "workspace number 1";
      floating.criteria = [
        {
          title = "图片查看器";
        }
      ];
    };
  };
}
