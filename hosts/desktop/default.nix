{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/tipparn

    ../common/optional/pipewire.nix
    ../common/optional/wireless.nix
  ];

  networking = {
    hostName = "desktop";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
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
    light.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
