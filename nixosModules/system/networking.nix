{ pkgs, config, lib, ... }:

{
  options = {
    system.networking.enable = lib.mkEnableOption "enables networking";
  };

  config = lib.mkIf config.system.networking.enable {
    networking.networkmanager.enable = true;
  };

}
