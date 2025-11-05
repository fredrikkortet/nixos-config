{
    programs.gpg = {
        enable = true;
    };
    services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 60;
        maxCacheTtl = 100;
    };
}
