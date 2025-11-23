{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.home.homeDirectory}/.wallpaper/wallpaper.jpg";
      wallpaper = ",${config.home.homeDirectory}/.wallpaper/wallpaper.jpg";
    };
  };
}
