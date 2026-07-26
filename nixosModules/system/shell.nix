{ pkgs, config, lib, ... }:

{
  options = {
    system.shell.enable = lib.mkEnableOption "enables shell configuration";
  };

  config = lib.mkIf config.system.shell.enable {
    programs = {
      zsh.enable = true;

      starship.enable = true;
    };

    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      lsd
      bat
      fzf
    ];
  };
}
