{
services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
        PasswordAuthentication = false;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = false;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
};
networking.firewall.allowedTCPPorts = [ 2222 ];
}

