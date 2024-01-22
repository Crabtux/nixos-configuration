{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;

  users.users.crabtux = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ]; 
  };
}
