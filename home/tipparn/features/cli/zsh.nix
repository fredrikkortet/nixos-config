{
    config,
    ...
}: {
    programs.zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        history = {
            path = "${config.programs.zsh.dotDir}/zsh_history";
            size = 1000000;
            save = 1000000;
        };
        shellAliases = {
            vim = "nvim";
            psmem = "ps auxf | sort -nr -k 4 | head -5";
        };
        prezto = {
            enable = true;
            tmux.autoStartLocal = true;
            tmux.defaultSessionName = "Home";
            pmodules = [
                "environment"
                "terminal"
                "editor"
                "history"
                "directory"
                "spectrum"
                "utility"
                "completion"
                "prompt"
                "tmux"
            ];
        };
    };
}
