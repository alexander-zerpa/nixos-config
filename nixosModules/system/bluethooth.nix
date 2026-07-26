{ pkgs, config, lib, ... }:

{
  options = {
    system.bluetooth.enable = lib.mkEnableOption "enables bluetooth";
  };

  config = lib.mkIf config.system.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    services.blueman.enable = true;
  };

}
