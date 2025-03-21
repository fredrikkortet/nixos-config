{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (myLib.filesIn ./included);
  programs.corectrl.enable = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.steam.enable = true;
  programs.steam.extraPackages = with pkgs; [
    SDL2
    libsForQt5.full
  ];
   home-manager.backupFileExtension = ".backup";

  boot = {
    # kernelPackages = pkgs.linuxPackages_zen;
    loader.grub.enable = true;
    loader.grub.efiSupport = true;
    loader.grub.efiInstallAsRemovable = true;

    supportedFilesystems.ntfs = true;

    kernelParams = ["quiet" "amd_pstate=guided" "processor.max_cstate=1"];
    kernelModules = ["coretemp" "cpuid" "v4l2loopback"];

    # kernelPatches = [
    #   # for vr
    #   {
    #     name = "amdgpu-ignore-ctx-privileges";
    #     patch = pkgs.fetchpatch {
    #       name = "cap_sys_nice_begone.patch";
    #       url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
    #       hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
    #     };
    #   }
    # ];
  };

  boot.plymouth.enable = true;

  services.xserver.videoDrivers = ["amdgpu"];
  boot.initrd.kernelModules = ["amdgpu"];

  myNixOS = {
    bundles.general-desktop.enable = true;
    hyprland.enable = true;
    power-management.enable = true;

    virtualisation.enable = lib.mkDefaut true;

    bundles.users.enable = true;
    home-users = {
      "tipparn" = {
        userConfig = ./home.nix;
        userSettings = {
          extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "adbusers" "openrazer"];
        };
      };
    };

  };
  users.users.yurii.hashedPasswordFile = "/persist/passwd";

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };

  # hardware.openrazer.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  services = {
    hardware.openrgb.enable = true;
    flatpak.enable = true;
    udisks2.enable = true;
    printing.enable = true;
  };

  programs.zsh.enable = true;
  programs.adb.enable = true;

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    glib
  ];

  hardware.graphics.enable = true;
  # hardware.graphics.enable32Bit = true;
  #
  # hardware.graphics.extraPackages = with pkgs; [
  #   amdvlk
  # ];
  #
  # hardware.graphics.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];

  system.stateVersion = "23.11";
}
