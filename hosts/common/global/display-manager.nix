{config, lib, pkgs, ...}: {
  users.groups.greeter = { };
  users.users.greeter = {
      isSystemUser = true;
      group = "greeter";
    };
  services = {
    displayManager = {
      enable = true;
      # Export user sessions to system
      sessionPackages = lib.flatten (lib.mapAttrsToList (_: v: v.home.exportedSessionPackages) config.home-manager.users);
      ly = {
        enable = true;
      };
    };
  };
}
