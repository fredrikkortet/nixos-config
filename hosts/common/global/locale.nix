{
    lib,
    ...
}: {
    i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        extraLocaleSettings = {
            LC_TIME = lib.mkDefault "en_US.UTF-8";
        };
        supportedLocales = lib.mkDefault [
            "en_US.UTF-8/UTF-8"
        ];
    };

    console.keyMap = lib.mkDefault "sv-latin1";
    location.provider = "geoclue2";
    time.timeZone = lib.mkDefault "Europe/Stockholm";
}
