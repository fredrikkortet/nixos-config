{
  config,
  ...
}:
{
  hardware.bluetooth = {
    enable = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;

    networks = {
      "Cryosat" = {
        pskRaw = "03a97d58eb226e4c9fb2743314455af0911dddab42190d881c623173432bc8f0";
      };
      "aeolus" = {
        pskRaw = "4513c03b6ebd60caed2bc661b932137b3946aff73734ce51bf6b2f3dfe02eab4";
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
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
