{
    pkgs,
    ...
}: {
    imports = [
        ./global
        ./features/desktop/common
        #./features/desktop/hyprland
        ./features/desktop/wireless
    ];

    monitors = [
        {
            name = "eDP-1";
            width = 1920;
            height = 1080;
            workspace = "1";
            primary = true;
        }
    ];
}
