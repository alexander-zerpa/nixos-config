{ pkgs, config, lib, ... }:

{
  options = {
    system.fonts.enable = lib.mkEnableOption "enables fonts";
  };

  config = lib.mkIf config.system.fonts.enable {
    fonts = {
      enableDefaultPackages = false;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.symbols-only
        dejavu_fonts
        unifont
        noto-fonts-color-emoji
      ];
      fontconfig = {
        defaultFonts = {
          serif = [ "DejaVuSansM Nerd Font" ];
          sansSerif = [ "DejaVuSansM Nerd Font" ];
          monospace = [
            "JetBrainsMono Nerd Font"
            "DejaVuSansM Nerd Font"
            "DejaVu Sans Mono"
            "Noto Color Emoji"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
      fontDir.enable = true;
    };
  };
}
