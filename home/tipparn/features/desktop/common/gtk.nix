{
  config,
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    font = {
      inherit (config.fontProfiles.regular) name size;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      package = pkgs.apple-cursor;
      name = "macOS-BigSur";
      size = 24;
    };
  };

  services.xsettingsd = {
    enable = true;
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
