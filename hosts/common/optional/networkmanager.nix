{
    config,
    ...
}: {
    hardware.bluetooth = {
        enable = true;
    };

    networking.networkmanager.enable = true;

    # Ensure group exists
    users.groups.networkmanager = {};
}
