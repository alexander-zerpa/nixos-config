{ pkgs, lib, config, ... }:

{
  options = {
    desktop.sway.enable = lib.mkEnableOption "enables sway wm";
  };

  config = lib.mkIf config.desktop.sway.enable {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        swayidle
        swaylock-effects
        swayosd
        rofi
        i3status-rust
        imv
        wl-clipboard

        sway-contrib.grimshot
      ];
    };

    xdg.portal.wlr.enable = true;
  };
}
