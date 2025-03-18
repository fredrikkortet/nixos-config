{ pkgs, lib, config, ...}:

with lib;
let cfg =
    config.modules.packages;
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintencance}'';

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            #custom scripts
            maintenance

            # Terminal
            zsh
            alacritty
            starship
            neovim
            eza
            rofi
            feh
            fzf
            fd
            ripgrep
            openvpn
            stow
            #youtube-dl

            # Fonts
            nerdfonts

            # Application
            firefox
            libreoffice
            pcmanfm
            prusa-slicer
            gimp
            discord
            steam
            gparted
            logseq
            arandr
            pavucontrol
            nextcloud-client
            syncthing
            calibre
            networkmanager-openvpn
            vlc
            zathura
            #freecad

            # Tools
            git
            zip
            unzip
            wget
            tree-sitter
            inetutils
            alsa-utils

            # Languages
            lua
            luajitPackages.luarocks
            cargo
            gcc
            python3Full
            nodejs_22
        ];
    };
}
