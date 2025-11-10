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
}
