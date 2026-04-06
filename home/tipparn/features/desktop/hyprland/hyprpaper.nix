{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/.wallpaper/wallpaper.jpg";
        }
      ];
    };
  };
}
