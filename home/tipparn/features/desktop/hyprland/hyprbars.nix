{
  config,
  pkgs,
  lib,
  ...
}:
let
  hyprbars =
    (pkgs.hyprlandPlugins.hyprbars.override {
      # Make sure it's using the same hyprland package as we are
      hyprland = config.wayland.windowManager.hyprland.package;
    }).overrideAttrs
      (old: {
        # Yeet the initialization notification (I hate it)
        postPatch = (old.postPatch or "") + ''
          ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
        '';
      });
in
{
  wayland.windowManager.hyprland = {
    plugins = [ hyprbars ];
    settings = {
      "plugin:hyprbars" = {
        bar_height = 25;
        bar_part_of_window = true;
        bar_precedence_over_border = true;
      };

    };
  };
}
