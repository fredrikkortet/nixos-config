{
    lib,
    pkgs,
    config,
    outputs,
    ...
}: {
    imports = [
        ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

    nix = {
        package = lib.mkDefault pkgs.nix;
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            #warn-dirty = false;
        };
    };
    systemd.user.startServices = "sd-switch";

    programs = {
        home-manager.enable = true;
    };

    home = {
        username = lib.mkDefault "tipparn";
        homeDirectory = lib.mkDefault "/home/${config.home.username}";
        stateVersion = lib.mkDefault "22.05";
        sessionPath = ["$HOME/.local/bin"];
        sessionVariables = {
            FLAKE = "$HOME/flake";
        };
    };
}
