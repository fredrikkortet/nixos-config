{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    #../common/wayland-wm

    #./basic-binds.nix
    #./hyprbars.nix
    #./hyprlock.nix
    #./hypridle.nix
    #./hyprpaper.nix
  ];

  xdg.portal = {
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config.hyprland = {
      default = ["hyprland" "gtk"];
    };
  };

  home.packages = [
    pkgs.grimblast
    pkgs.hyprpicker
  ];

  home.exportedSessionPackages = [config.wayland.windowManager.hyprland.package];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
