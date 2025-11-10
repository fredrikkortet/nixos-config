{ config, ... }:
{
  # Set as default terminal
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = config.fontProfiles.monospace.size;
        bold = {
          family = config.fontProfiles.monospace.name;
          style = "Bold";
        };
        normal = {
          family = config.fontProfiles.monospace.name;
          style = "Regular";
        };
      };
      cursor = {
        style = "Block";
      };
      scrolling = {
        history = 10000;
      };
      window = {
        opacity = 0.9;
        startup_mode = "Windowed";
      };
    };
  };
}
