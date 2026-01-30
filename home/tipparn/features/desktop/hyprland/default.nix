{
  lib,
  config,
  pkgs,
  ...
}:
let
  grimblast = lib.getExe pkgs.grimblast;
  pactl = lib.getExe' pkgs.pulseaudio "pactl";
  defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";

in
{
  imports = [
    ../common
    ../common/wayland-wm

    ./basic-binds.nix
    #./hyprbars.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  home.packages = [
    pkgs.grimblast
    pkgs.hyprpicker
  ];

  home.exportedSessionPackages = [ config.wayland.windowManager.hyprland.package ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        allow_tearing = false;
        #"col.active_border" = rgba config.colorscheme.colors.primary "ee";
        #"col.inactive_border" = rgba config.colorscheme.colors.surface "aa";

      };
      cursor.inactive_timeout = 4;
      input = {
        kb_layout = "se";
      };
      dwindle = {
        split_width_multiplier = 1.35;
        pseudotile = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        rounding = 0;
        blur = {
          enabled = false;
          size = 4;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          popups = true;
        };
        shadow = {
          enabled = false;
          offset = "3 3";
          range = 12;
          color = "0x44000000";
          color_inactive = "0x66000000";
        };
      };
      animations = {
        enabled = false;
      };
      # Will repeat when held, also works when locked
      bindel = [
        ",XF86MonBrightnessUp,exec,brightnessctl s +10%"
        ",XF86MonBrightnessDown,exec,brightnessctl s 10%-"
        # Volume
        ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        "SHIFT,XF86AudioRaiseVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ +5%"
        "SHIFT,XF86AudioLowerVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ -5%"
      ];
      # Also works when locked
      bindl = [
        ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
        "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
      # Normal binding
      bind = [
        "SUPERSHIFT,p,exec,wofi --show drun"
        "SUPERSHIFT,x,exec,powermenu"
        "SUPERSHIFT,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
        "SUPERSHIFT,w,exec,${defaultApp "x-scheme-handler/https"}"
        ",Print,exec,${grimblast} --freeze copy area"
        "SHIFT,Print,exec,${grimblast} --freeze copy output"
      ];
      monitor = let
        waybarSpace = let
          inherit (config.wayland.windowManager.hyprland.settings.general) gaps_in gaps_out;
          inherit (config.programs.waybar.settings.primary) position height width;
          gap = gaps_out - gaps_in;
        in {
          top =
            if (position == "top")
            then height + gap
            else 0;
          bottom =
            if (position == "bottom")
            then height + gap
            else 0;
          left =
            if (position == "left")
            then width + gap
            else 0;
          right =
            if (position == "right")
            then width + gap
            else 0;
        };
      in
        [
          ",addreserved,${toString waybarSpace.top},${toString waybarSpace.bottom},${toString waybarSpace.left},${toString waybarSpace.right}"
        ]
        ++ (map (
          m: "${m.name},${
            if m.enabled
            then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${m.scale}"
            else "disable"
          }"
          ) (config.monitors));
      workspace = map (m: "${m.workspace},monitor:${m.name}") (
        lib.filter (m: m.enabled && m.workspace != null) config.monitors
      );
    };
  };
}
