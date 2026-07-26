{ pkgs, config, lib, ... }:

{
  options = {
    desktop.launchers.enable = lib.mkEnableOption "enables launchers";
  };

  config = lib.mkIf config.desktop.launchers.enable {
    environment.systemPackages = with pkgs; [
      rofi
      # launcher based menus
      # iwmenu
      # pwmenu
      # bzmenu
      rofi-network-manager
      rofi-bluetooth
      rofi-pulse-select
    ];
  };
}
