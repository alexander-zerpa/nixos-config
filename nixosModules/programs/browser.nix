{ pkgs, config, lib, ... }:

{
  options = {
    programs.browser.enable = lib.mkEnableOption "enables web browser";
  };

  config = lib.mkIf config.programs.browser.enable {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.librewolf;
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          Preferences = {
          };
          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            "idcac-pub@guus.ninja" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
              installation_mode = "force_installed";
            };
            "keepassxc-browser@keepasscx.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        };
        nativeMessagingHosts.packages = [ pkgs.tridactyl-native ];
        languagePacks = [ "en-US" "es-ES" ];
      };
    };
  };
}
