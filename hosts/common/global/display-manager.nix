{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.groups.greeter = { };
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
  };
  services = {
    displayManager = {
      enable = true;
      # Export user sessions to system
      sessionPackages = lib.flatten (
        lib.mapAttrsToList (_: v: v.home.exportedSessionPackages) config.home-manager.users
      );
      sddm = {
        enable = true;
        extraPackages = [
            pkgs.kdePackages.qtmultimedia
        ];
        theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
        wayland.enable = true;
      };
    };
  };
}
