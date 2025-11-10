{
  ...
}:
{
  programs.librewolf = {
    enable = true;
    profiles.tipparn = {
      #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #  ublock-origin
      #  browserpass
      #];
      settings = {
        # Don't ask for download dir
        "browser.download.useDownloadDir" = false;

        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "librewolf.desktop" ];
    "text/xml" = [ "librewolf.desktop" ];
    "x-scheme-handler/http" = [ "librewolf.desktop" ];
    "x-scheme-handler/https" = [ "librewolf.desktop" ];
  };
}
