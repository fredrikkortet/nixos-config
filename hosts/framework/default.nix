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
    hostName = "framework";
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

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          rightalt = "layer(number_one)";
        };
        number_one = {
          # Home row
          a = "G-1";
          s = "G-2";
          d = "G-3";
          f = "G-4";
          g = "G-102nd";
          h = "G-rightbrace";
          j = "G-7";
          k = "G-8";
          l = "G-9";
          semicolon = "G-0";
          apostrophe = "G-minus";
        };
      };
    };
  };

  # lid settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
