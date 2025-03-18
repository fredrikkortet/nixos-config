{
  ...
}: {

    services = {
        # Enable picom
        picom = {
            enable = true;
            fade = true;
            shadow = true;
            fadeDelta = 4;
        };
        # Qtile
        xserver = {
            enable = true;
            windowManager.qtile.enable = true;
        };
    };
	qt = {
		enable = true;
		platformTheme = "gtk2";
		style = "gtk2";
	};
}
