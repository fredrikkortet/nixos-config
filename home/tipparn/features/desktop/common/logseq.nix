{
    pkgs,
    ...
}:
let
  # Create a customized version of logseq
  logseq-patch = pkgs.logseq.override {
    electron = pkgs.electron_34;
  };
in {

  home.packages = [
    logseq-patch
  ];
}
