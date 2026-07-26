{ pkgs, config, lib, ... }:

{
  options = {
    programs.fileManager.enable = lib.mkEnableOption "enables file manager";
  };

  config = lib.mkIf config.programs.fileManager.enable {
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    environment.systemPackages = with pkgs; [
      pcmanfm
      lxmenu-data
      shared-mime-info
      xarchiver
      ffmpegthumbnailer
      imagemagick
      ghostscript
      gnome-epub-thumbnailer
      webp-pixbuf-loader
    ];
  };
}
