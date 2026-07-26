{ pkgs, config, lib, ... }:

{
  options = {
    desktop.xserver.enable = lib.mkEnableOption "enables xserver";
  };

  config = lib.mkIf config.desktop.xserver.enable {
    services = {
      xserver = {
        enable = true;

        desktopManager.xterm.enable = false;
        excludePackages = with pkgs; [ xterm ];
      };

      picom = {
        enable = true;
        vSync = true;
      };
    };

    environment.systemPackages = with pkgs; [
      dunst
    ];
  };
}
