{
    config,
    ...
}: {
    hardware.bluetooth = {
        enable = true;
    };

    networking.wireless = {
        enable = true;
        fallbackToWPA2 = false;

        networks = {
            "sara2.4" = {
                psk = "UlMaSaGu";
            };
        };

        allowAuxiliaryImperativeNetworks = true;
        userControlled = {
            enable = true;
            group = "network";
        };
        extraConfig = ''
            update_config=1
        '';
    };

    # Ensure group exists
    users.groups.network = {};
    
    systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
