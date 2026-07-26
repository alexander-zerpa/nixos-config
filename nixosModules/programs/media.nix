{ pkgs, config, lib, ... }:

{
  options = {
    programs.media.enable = lib.mkEnableOption "enables media";
  };

  config = lib.mkIf config.programs.media.enable {
    environment.systemPackages = with pkgs; [
      ffmpeg
      mpv
    ];
  };
}
