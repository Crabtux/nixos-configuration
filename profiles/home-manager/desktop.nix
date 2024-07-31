{ pkgs, outputs, ... }: 

{
  imports = [
    outputs.homeManagerModules.rain
  ];

  home = {
    username = "crabtux";
    homeDirectory = "/home/crabtux";
  };

  rain.home-manager = {
    software = {
      desktop.enable = true;
      cli.enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
