{ lib, ... }:

with lib; {
  imports = [
    ./applications.nix
    ./games.nix
    ./tools.nix
  ];

  options = {
    mySystem.software = {
      desktop = {
        applications.enable = mkEnableOption "desktop application";
        games.enable = mkEnableOption "desktop games";
        tools.enable = mkEnableOption "desktop tools";
      };
    };
  };
}
