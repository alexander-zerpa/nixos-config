{ pkgs, config, lib, ... }:

{
  imports = [
    ./system
    ./desktop
    ./development
    ./programs
  ];

  config = {
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [ ];
    };

    # system.copySystemConfiguration = true;

    system.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;

    programs.enable = lib.mkDefault true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
      options = "compose:ralt";
    };


    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
