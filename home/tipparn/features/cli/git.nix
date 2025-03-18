{
    pkgs,
    config,
    lib,
    ...
}: {
    programs.git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;
        userName = "Fredrik kortetjärvi";
        userEmail = lib.mkDefault "49959669+fredrikkortet@users.noreply.github.com";
        extraConfig = {
            init.defaultBranch = "main";
            diff.algorithm = "histogram";
            log.date = "iso";
        };
        lfs.enable = true;
        ignores = [
            ".direnv"
        ];

    };
    
}
