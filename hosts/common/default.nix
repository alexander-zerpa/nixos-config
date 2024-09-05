{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services = {
    displayManager = {
      sddm.enable = true;
    };

    xserver = {
      enable = true;

      # resolutions = [ { x = 1920; y = 1080; } ];

      windowManager.awesome = {
        enable = true;
      };
    };
  };

  programs = {
    git.enable = true;

    zsh.enable = true;

    starship.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    lsd
    bat
    stow
    alacritty
    librewolf
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DejaVuSansMono" ]; })
    font-awesome
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
