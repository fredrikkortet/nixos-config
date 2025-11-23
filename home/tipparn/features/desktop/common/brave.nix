{
  pkgs,
  lib,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "oboonakemofpalcgghocfoadofidjkkk"; }
    ];
  };
  xdg.mimeApps = {
    defaultApplications = {
      "text/html" = [ "brave.desktop" ];
      "text/xml" = [ "brave.desktop" ];
      "x-scheme-handler/http" = [ "brave.desktop" ];
      "x-scheme-handler/https" = [ "brave.desktop" ];
    };
  };
}
