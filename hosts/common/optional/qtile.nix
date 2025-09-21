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
            windowManager.qtile = {
                enable = true;
                extraPackages = python3Packages: with python3Packages; [
                    #qtile-extras
                ];
            };
        };
    };
	qt = {
		enable = true;
		platformTheme = "gtk2";
		style = "gtk2";
	};
    # Lockscreen settings
    security.pam.services.i3lock.enable = true;
}
