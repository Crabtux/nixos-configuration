{ config, pkgs, lib, ... }:

{
  # If I don't repeat it here, it will generate errors.
  programs.fish.enable = true;

  users.users.crabtux = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ]; 
    shell = pkgs.fish;
  };
}
