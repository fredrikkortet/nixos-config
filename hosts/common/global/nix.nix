{
    inputs,
    lib,
    ...
}: let
    # Filter out flakes sources only  
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in{
    nix = {
        settings = {
            trusted-users = [
                "root"
                "@wheel"
            ];
            auto-optimise-store = lib.mkDefault true;
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            warn-dirty = false;
            system-features = [
                "kvm"
                "big-parallel"
                "nixos-test"
            ];
            flake-registry = ""; # Disable global flake registry
        };
        # Automatic Garbage Collection
        gc = {
            automatic = true;
            dates = "weekly";
            # keep the last 5 generations
            options = "--delete-older-than +5";
        };

        # Add each flake input as a registry and nix_path
        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
    # Auto upgrade system
    system.autoUpgrade.enable = true;
}
