{ pkgs, config, lib, ... }:

{
  options = {
    desktop.i3.enable = lib.mkEnableOption "enables i3 wm";
  };

  config = lib.mkIf config.desktop.i3.enable {
    desktop.xserver.enable = true;

    services.xserver = {
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          brightnessctl
          i3lock-fancy-rapid
          dmenu
          rofi
          i3status-rust
          sxiv
        ];
      };
    };
  };
}
