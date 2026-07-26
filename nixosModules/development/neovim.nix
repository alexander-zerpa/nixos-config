{ pkgs, config, lib, ... }:

{
  options = {
    development.neovim.enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.development.neovim.enable {
    environment.systemPackages = with pkgs; [
      (neovim.override {
        extraMakeWrapperArgs = ''
          --prefix PATH : ${
            lib.makeBinPath [
              gcc
              tree-sitter
              fd
              ripgrep
            ]
          }
        '';
      })
    ];
    environment.sessionVariables.EDITOR = "nvim";
  };
}
