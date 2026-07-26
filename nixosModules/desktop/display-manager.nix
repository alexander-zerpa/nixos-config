{ pkgs, config, lib, ... }:

{
  options = {
    desktop.displayManager.enable =
      lib.mkEnableOption "enables display manager";
  };

  config = lib.mkIf config.desktop.displayManager.enable {
    services.displayManager = {
      ly = {
        enable = true;
        settings = {
          battery_id = "BAT1";
          clear_password = true;
          text_in_center = true;
          vi_mode = true;
          vi_default_mode = "insert";
        };
      };
      autoLogin.enable = false;
    };
  };
}
