{ pkgs, config, lib, ... }:

{
  options = {
    programs.terminal.enable = lib.mkEnableOption "enables terminal";
  };

  config = lib.mkIf config.programs.terminal.enable {
    environment.systemPackages = with pkgs; lib.mkIf config.services.xserver.enable [
      alacritty-graphics
      ueberzugpp
    ];

    environment.sessionVariables = {
      TERMINAL = "alacritty";
    };
  };
}
