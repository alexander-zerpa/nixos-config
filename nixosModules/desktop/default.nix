{ pkgs, config, lib, ... }:

{
  imports = [
    ./plymouth.nix
    ./display-manager.nix
    ./window-manager/i3.nix
    ./window-manager/sway.nix
    ./xserver.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "enables desktop enviroment";

  };

  config = lib.mkIf config.desktop.enable {
    desktop.plymouth.enable = lib.mkDefault true;
    desktop.displayManager.enable = lib.mkDefault true;
    desktop.i3.enable = lib.mkDefault true;
    desktop.sway.enable = lib.mkDefault true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = "gtk";
    };

    desktop.xserver.enable = lib.mkDefault config.services.xserver.enable;
  };
}
