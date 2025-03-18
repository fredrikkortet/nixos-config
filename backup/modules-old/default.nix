{ inputs, pkgs, config, ...}:

{
    home.stateVersion = "24.11";
    imports = [
        ./amd-drivers
        ./packages
        ./system

    ];
}
