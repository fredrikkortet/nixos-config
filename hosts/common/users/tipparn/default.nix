{
    pkgs,
    config,
    ...
}: let
    ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
    users.mutableUsers = false;
    users.users.tipparn = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ifTheyExist [
            "audio"
            "video"
            "wheel"
            "network"
        ];
        hashedPassword = "$6$l9NT4neC12LICEzS$60H5FEb08V5iMpb1WveIuB8RQHp7PXG5TsO0cnw9xf4bdUNXBYhXqeUirOgngPko3WCB/MXVT.1I5QAxfmZkh0";
    
        packages = [pkgs.home-manager];
    };

    home-manager.users.tipparn = import ../../../../home/tipparn/${config.networking.hostName}.nix;


}
