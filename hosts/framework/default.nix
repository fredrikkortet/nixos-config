{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.framework-amd-ai-300-series

    ./hardware-configuration.nix

    ../common/global
    ../common/users/tipparn

    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/qtile.nix
    ../common/optional/polkit.nix
    ../common/optional/inputdevice.nix
    ../common/optional/ssh.nix
    #../common/optional/wireless.nix
    ../common/optional/networkmanager.nix
  ];

  networking = {
    hostName = "laptop";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
    initrd.kernelModules = [ "amdgpu" ];
    initrd.luks.devices."luks-5d80e3bc-696c-4342-9354-79ca16fd89fb".device =
      "/dev/disk/by-uuid/5d80e3bc-696c-4342-9354-79ca16fd89fb";
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        configurationLimit = 10;
      };
      timeout = 5;
    };
  };

  powerManagement.powertop.enable = true;
  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  # lid settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
