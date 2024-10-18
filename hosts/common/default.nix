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
      sddm = {
        enable = true;
        theme = "chili";
      };
      autoLogin.enable = true;
    };

    xserver = {
      enable = true;

      # resolutions = [ { x = 1920; y = 1080; } ];

      windowManager.awesome = {
        enable = true;
      };
    };
  };

  # Audio config
  # alsa
  sound.enable = true;
  # pipewire
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # jack.enable = true;
  # };
  # pulseaudio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  programs = {
    git.enable = true;

    zsh.enable = true;

    starship.enable = true;

    direnv.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lsd
    bat
    stow
    alacritty
    librewolf
    keepassxc
    xclip
    xdg-desktop-portal-gtk
    sddm-chili-theme
    ffmpeg
    pavucontrol
  ];

  systemd.user.services.keepassAuto = {
    script = "${pkgs.keepassxc}/bin/keepassxc";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

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
    options = "compose:ralt";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
