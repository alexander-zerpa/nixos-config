{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alexander";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    packages = with pkgs; [];
  };
}
