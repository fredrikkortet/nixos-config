{
    pkgs,
    config,
    ...
}:

let 
    # Path where the script will be created
    scriptPath = "${config.home.homeDirectory}/.local/bin/changevol";
in
{
    # Add dependencies for script
    home.packages = with pkgs; [
        alsa-utils
    ];

    # Create a change volume script using amixer
    home.file = {
        "${scriptPath}" = {
            source = ./script/changevol;
            executable = true;
        };
    };
}
