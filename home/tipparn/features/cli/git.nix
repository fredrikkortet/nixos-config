{
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Fredrik kortetjärvi";
      user.email = lib.mkDefault "49959669+fredrikkortet@users.noreply.github.com";
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
