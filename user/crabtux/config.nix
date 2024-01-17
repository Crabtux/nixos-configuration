{ config, pkgs, lib, ... }:

{
  # If I don't repeat it here, it will generate errors.
  programs.fish.enable = true;
  programs.steam.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users.crabtux = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ]; 
  };
}
