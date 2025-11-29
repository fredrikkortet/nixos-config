{ config, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      auth.fingerprint.enabled = true;
      general = {
        hide_cursor = true;
      };
      animations = {
        enabled = false;
      };
      background = {
        path = "screenshot";
        blur_passes = 4;
      };
      input-field = {
        font_family = config.fontProfiles.regular.name;
        position = "0, -20%";
        # $FAIL is moves to another label
        fail_text = "";
        # Hide outline and filling
        outline_thickness = 0;
        inner_color = "rgba(00000000)";
        check_color = "rgba(00000000)";
        fail_color = "rgba(00000000)";
      };
      label = [
        {
          text = "$TIME";
          font_family = config.fontProfiles.regular.name;
          font_size = "140";
          position = "0 0";
        }
        {
          text = "$FAIL";
          font_family = config.fontProfiles.regular.name;
          font_size = "18";
          position = "0, -40%";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind =
        let
          hyprlock = lib.getExe config.programs.hyprlock.package;
        in
        [
          "SUPER,backspace,exec,${hyprlock}"
          "SUPER,XF86Calculator,exec,${hyprlock}"
        ];
    };
  };
}
