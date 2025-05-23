{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../common
      ./../../users/alex
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;

  networking.hostName = "zaleos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  sops = {
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      ssh-host = {
        sopsFile = ./secrets.yaml;
      };
    };
  };

  users.users.alex.hashedPasswordFile = config.sops.secrets.alex-password.path;

  system.activationScripts = {
    ssh-host.text = "cp ${config.sops.secrets.ssh-host.path} /etc/ssh/ssh_host_ed25519_key";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.kmonad = {
    enable = true;
    keyboards = {
      "home-rows" = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
        };
        config = ''
          (defsrc
              caps    a    s    d    f    g    h    j    k    l    ;
          )
          (defalias
              alt_a (tap-hold-next-release 200 a lalt)
              ctl_s (tap-hold-next-release 200 s lctl)
              met_d (tap-hold-next-release 200 d lmet)
              sft_f (tap-hold-next-release 125 f lsft)

              sft_j (tap-hold-next-release 125 j rsft)
              met_k (tap-hold-next-release 200 k rmet)
              ctl_l (tap-hold-next-release 200 l rctl)
              alt_; (tap-hold-next-release 200 ; lalt)
          )
          (deflayer homerowmods
              esc     @alt_a   @ctl_s   @met_d   @sft_f   g   h   @sft_j   @met_k   @ctl_l   @alt_;
          )
          '';
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    arc-icon-theme
    acpi
    slack
    polkit_gnome
  ];

  security.polkit.enable = true;

  programs.light.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];

  virtualisation.docker.enable = true;

  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --primary --auto --output eDP-1 --auto --right-of HDMI-1";

  # List services that you want to enable:

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  systemd.user.services.slackAuto = {
    script = "${pkgs.slack}/bin/slack";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = false;
      hostKeys = [];
    };

    syncthing = {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "Pixel 7a" = { id = "ALYRLWH-67OM7IF-NKW3C6R-MSS6M2D-IVFN76A-74HIENM-PD5QWZP-CUQJGQX"; };
        };
        folders = {
          "KeePass" = {
            id = "mqgyv-htiuw";
            path = config.services.syncthing.dataDir + "/keepass";
            devices = [ "Pixel 7a" ];
          };
        };
      };
    };
  };

  # networking.firewall.allowedTCPPorts = [ 22000 ];
  # networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
