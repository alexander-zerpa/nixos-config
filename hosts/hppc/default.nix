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

  networking.hostName = "hppc"; # Define your hostname.
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    arc-icon-theme
    exfatprogs
    polkit_gnome
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --primary --auto --output DVI-D-0 --auto --below HDMI-0 --output DP-0 --auto --right-of DVI-D-0";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  security.polkit.enable = true;

  programs.light.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  virtualisation.docker.enable = true;

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
            ignorePerms = true;
          };
          "PhoneBackup" = {
            id = "vxfq2-5ni1c";
            path = "/mnt/External/Documents/Backups/Phone";
            devices = [ "Pixel 7a" ];
            ignorePerms = true;
          };
          "Camera" = {
            id = "uhicb-k46un";
            path = "/mnt/External/Documents/phone/Camera";
            devices = [ "Pixel 7a" ];
            ignorePerms = true;
          };
          "WhatsApp" = {
            id = "9x00m-w24p7";
            path = "/mnt/External/Documents/phone/WhatsApp";
            devices = [ "Pixel 7a" ];
            ignorePerms = true;
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22000 32400 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
