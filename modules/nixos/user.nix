{ pkgs, ... }:

{
  # If I don't repeat it here, it will generate errors.
  users.defaultUserShell = pkgs.fish;

  users.users.crabtux = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" ]; 
  };
}
