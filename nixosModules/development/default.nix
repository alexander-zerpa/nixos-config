{ pkgs, config, lib, ... }:

{
  imports = [
    ./neovim.nix
  ];

  options = {
    development.enable = lib.mkEnableOption "enable development";
  };

  config = lib.mkIf config.development.enable {
    development.neovim.enable = lib.mkDefault true;

    programs = {
      git.enable = true;

      direnv = {
        enable = true;
        settings = {
          log_format = "[2mdirenv: %s[0m";
          hide_env_diff = true;
        };
      };
    };
  };
}
