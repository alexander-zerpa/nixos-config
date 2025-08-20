{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };

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

      desktopManager.xterm.enable = false;
      excludePackages = with pkgs; [ xterm ];
    };

    picom = {
      enable = true;
      vSync = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  # Audio config
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
  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  programs = {
    git.enable = true;

    zsh.enable = true;

    starship.enable = true;

    direnv.enable = true;

    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 5";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
    };

    thunderbird.enable = true;

    firefox = {
      enable = true;
      package = pkgs.librewolf;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        Preferences = {
        };
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "idcac-pub@guus.ninja" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
            installation_mode = "force_installed";
          };
          "keepassxc-browser@keepasscx.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      nativeMessagingHosts.packages = [ pkgs.tridactyl-native ];
      languagePacks = [ "en-US" "es-ES" ];
    };
  };

  users.defaultUserShell = pkgs.zsh;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lsd
    bat
    fzf
    stow
    alacritty
    ueberzugpp
    keepassxc
    xclip
    sddm-chili-theme
    ffmpeg
    pavucontrol
    discord
    zip
    unzip
    btop
    ripgrep
    # file-manager
    pcmanfm
    lxmenu-data
    shared-mime-info
    xarchiver
    ffmpegthumbnailer
    imagemagick
    ghostscript
    gnome-epub-thumbnailer
    webp-pixbuf-loader
    # end file-manager
    zathura
    qbittorrent
    mpv
    birdtray
  ];

  systemd.user.services.keepassAuto = {
    script = "${pkgs.keepassxc}/bin/keepassxc";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  systemd.user.services.birdtray = {
    script = "${pkgs.birdtray}/bin/birdtray";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.dejavu-sans-mono
      dejavu_fonts
      unifont
      noto-fonts-color-emoji
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "DejaVuSansM Nerd Font" "DejaVu Sans Mono" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ] ;
      };
    };
  };

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
