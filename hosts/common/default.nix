{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.git.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    lsd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
