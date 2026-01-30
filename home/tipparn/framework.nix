{
  ...
}:
{
  imports = [
    ./global
    ./features/desktop/common
    ./features/desktop/hyprland
    ./features/desktop/wireless
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 2880;
      height = 1920;
      workspace = "1";
      primary = true;
      refreshRate = 120;
    }
  ];
}
