{ pkgs, config, lib, ... }:

{
  options = {
    programs.email.enable = lib.mkEnableOption "enables email client";
  };

  config = lib.mkIf config.programs.email.enable {
    programs = {
      thunderbird.enable = true;
    };

    environment.systemPackages = with pkgs; lib.mkIf config.services.xserver.enable [
      birdtray
    ];

    systemd.user.services.birdtray = lib.mkIf config.services.xserver.enable {
      script = "${pkgs.birdtray}/bin/birdtray";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
  };
}
