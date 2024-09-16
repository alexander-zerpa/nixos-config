{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./sops.nix
    ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alexander";
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    packages = with pkgs; [];
  };

  services.syncthing = {
    user = "alex";
    dataDir = config.users.users.alex.home;
  };
}
