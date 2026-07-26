{ pkgs, config, lib, ... }:

{
  imports = [
    ./networking.nix
    ./bluethooth.nix
    ./audio.nix
    ./shell.nix
    ./fonts.nix
  ];

  options = {
    system.enable = lib.mkEnableOption "enables system settings";
  };

  config = lib.mkIf config.system.enable {
    system.networking.enable = lib.mkDefault true;
    system.bluetooth.enable = lib.mkDefault true;

    system.audio.enable = lib.mkDefault true;

    system.shell.enable = lib.mkDefault true;

    system.fonts.enable = lib.mkDefault true;
  };

}
