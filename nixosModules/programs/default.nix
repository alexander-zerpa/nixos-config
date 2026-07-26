{ pkgs, config, lib, ... }:

{
  imports = [
    ./browser.nix
    ./email.nix
    ./file-manager.nix
    ./media.nix
    ./terminal.nix
  ];

  options = {
    programs.enable = lib.mkEnableOption "enables programs";
  };

  config = lib.mkIf config.programs.enable {
    programs.browser.enable = lib.mkDefault true;
    programs.email.enable = lib.mkDefault true;
    programs.fileManager.enable = lib.mkDefault true;
    programs.media.enable = lib.mkDefault true;
    programs.terminal.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      stow

      pavucontrol
      discord
      keepassxc

      zip
      unzip

      btop

      zathura
      qbittorrent

      # 3d modeling
      openscad-unstable
    ];

    systemd.user.services.keepassAuto = {
      script = "${pkgs.keepassxc}/bin/keepassxc";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
  };
}
