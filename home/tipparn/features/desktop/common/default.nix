{
  pkgs,
  ...
}: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./brave.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./keepassxc.nix
    ./zathura.nix
    ./alacritty.nix
  ];

  home.packages = [
    pkgs.libnotify
    pkgs.dunst
    pkgs.handlr-regex
    (pkgs.writeShellScriptBin "xterm" ''
      handlr launch x-scheme-handler/terminal -- "$@"
    '')
    (pkgs.writeShellScriptBin "xdg-open" ''
      handlr open "$@"
    '')
  ];

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
