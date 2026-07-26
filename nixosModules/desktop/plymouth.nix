{ pkgs, config, lib, ... }:

{
  options = {
    desktop.plymouth.enable = lib.mkEnableOption "enables plymouth";
  };

  config = lib.mkIf config.desktop.plymouth.enable {
    boot.consoleLogLevel = 3;
    boot.initrd.systemd.enable = true;
    boot.initrd.verbose = false;
    boot.plymouth.enable = true;
    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
