{
  pkgs,
  ...
}:
{
  imports = [
    ./thunderbird.nix
    ./antigravity.nix
    ./librewolf.nix
    ./brave.nix
    ./libreoffice.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./zathura.nix
    ./alacritty.nix
    ./logseq.nix
  ];

  home.packages = [
    pkgs.libnotify
    pkgs.dunst
    pkgs.handlr-regex
    pkgs.arandr
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
