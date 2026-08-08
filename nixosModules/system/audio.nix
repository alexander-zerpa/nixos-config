{ pkgs, config, lib, ... }:

{
  options = {
    system.audio.enable = lib.mkEnableOption "enables audio";
  };

  config = lib.mkIf config.system.audio.enable {
    # pipewire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };
    # pulseaudio
    # services.pipewire.enable = false;
    # hardware.pulseaudio.enable = true;
    # hardware.pulseaudio.support32Bit = true;
    services.playerctld.enable = true;
  };
}
