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

    ];
    home.packages = with pkgs; [

        ripgrep
        htop
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
        zip
        unzip
        wget
        tree-sitter
        inetutils
        alsa-utils

        nixd
        nix-diff
        luajitPackages.luarocks

        alacritty

    ];
}
