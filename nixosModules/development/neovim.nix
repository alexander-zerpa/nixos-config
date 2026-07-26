{ pkgs, config, lib, ... }:

{
  options = {
    development.neovim.enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.development.neovim.enable {
    programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
        withNodeJs = true;
      };
    };

    environment.sessionVariables.EDITOR = "nvim";
  };
}
