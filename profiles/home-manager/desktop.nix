{ pkgs, outputs, ... }: 

{
  imports = [
    outputs.homeManagerModules.rain
  ];

  home = {
    username = "crabtux";
    homeDirectory = "/home/crabtux";
  };

  rain.home = {
    software = {
      desktop.enable = true;
      cli.enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
