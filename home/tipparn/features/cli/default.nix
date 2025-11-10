{
    pkgs,
    ...
}: {
    imports = [
        ./git.nix
        ./direnv.nix
        ./zsh.nix
        ./bash.nix
        ./fzf.nix
        ./starship.nix
        ./gnugp.nix
        ./volumecontrol.nix

    ];
    home.packages = with pkgs; [
        ripgrep
        htop
        starship
        neovim
        tmux
        eza
        rofi
        feh
        fd
        ripgrep
        openvpn
        zip
        unzip
        wget
        tree-sitter
        inetutils
        alsa-utils
        xsettingsd

        # Laptop specific
        brightnessctl

        # Language tools 
        nixd
        nixfmt-rfc-style
        nix-diff
        cargo
        luajitPackages.luarocks
        zulu

        # Languages
        gcc
        pyright
        nodejs_24

        # Lockscreen
        betterlockscreen

    ];
}
