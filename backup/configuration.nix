# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

    nixpkgs.config = {
	    # Allow unfree packages
        allowUnfree = true;
        permittedInsecurePackages = [
            "electron-27.3.11"
        ];
    	# nixpkgs.config.allowBroken = true;
    };
	# Automatic Grabage Collection
	nix = {
		settings.experimental-features = ["nix-command" "flakes" ];
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 30d";
		};

	};
	# AutoUpgrade system
	system.autoUpgrade = {
		enable = true;
	};
    # Bootloader.
    boot = {
        # get the latest linux kernel 
        kernelPackages = pkgs.linuxPackages_latest;
    
        #gpu driver
        initrd.kernelModules = ["amdgpu"];
        loader = {
            #systemd-boot.enable = true;

        efi = {
                    canTouchEfiVariables = true;
                    efiSysMountPoint = "/boot";
                };
        grub = {
            enable = true;
            devices = ["nodev"];
            efiSupport = true;
            # set limit to how many configuration files
            configurationLimit = 10;

                };
                timeout = 5;
        };
	};

  	# Networking
  	networking = {
  	
		hostName = "tipparn"; # Define your hostname.
		# wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		# Configure network proxy if necessary
		# proxy.default = "http://user:password@proxy:port/";
		# proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	  	# Enable networking
	  	networkmanager = {
            enable = true;
        };
	 
	  	# Open ports in the firewall.
	  	# firewall.allowedTCPPorts = [ ... ];
	  	# firewall.allowedUDPPorts = [ ... ];
	  	# Or disable the firewall altogether.
	  	# firewall.enable = false;
  	};
  
  	# Set your time zone.
  	time.timeZone = "Europe/Stockholm";

  	# Configure console keymap
  	console.keyMap = "sv-latin1";

  	i18n = {

	  	# Select internationalisation properties.
	  	defaultLocale = "en_US.utf8";

	  	extraLocaleSettings = {
            LC_ADDRESS = "en_US.utf8";
            LC_IDENTIFICATION = "en_US.utf8";
			LC_MEASUREMENT = "en_US.utf8";
			LC_MONETARY = "en_US.utf8";
			LC_NAME = "en_US.utf8";
			LC_NUMERIC = "en_US.utf8";
			LC_PAPER = "en_US.utf8";
			LC_TELEPHONE = "en_US.utf8";
			LC_TIME = "en_US.utf8";
		};
  	};
  
	# Services
	services = {
		# Enable the OpenSSH daemon.
		# openssh.enable = true;
		# Enable CUPS to print documents.
		printing.enable = true;
		blueman.enable = true;
		# PLASMA
		displayManager.sddm.enable = true;
		displayManager.sddm.wayland.enable = true;

        udev.packages = [
            pkgs.android-udev-rules
        ];

		# Enable picom
		picom = {
			enable = true;
			fade = true;
			shadow = true;
			fadeDelta = 4;
		};
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			#JACK applications
			#jack.enable = true;

			# use the example session manager 
			#(no others are packaged yet so this is enabled by default,
			# no need to redefine it in your config for now)
			#media-session.enable = true;
		};
		# Enable touchpad support.
		libinput.enable = true;

		# Graphics
		# Enable the X11 windowing system.
		xserver ={ 
			enable = true;


			# Configure keymap in X11
			xkb.layout = "se";
			xkb.variant = "";


			# Enable Lightdm
            #displayManager.lightdm = {
            #	enable = true;
            #	greeters.enso.enable = true;
            #	greeters.enso.blur = true;
            #	background = "/etc/nixos/alita.jpg";
            #};

			# Enable Qtile
			windowManager.qtile = {
				enable = true;
			};
	  	};
	};

    # Enable polkit   
    security.polkit.enable = true;
    

	# Hardware
	hardware = {
	        # Enable Bluetooth
	        bluetooth.enable = true;

	        pulseaudio.enable = false;
	};
  
	# Users
	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.tipparn = {
		isNormalUser = true;
	  	description = "tipparn";
	  	extraGroups = [ 
	      		"networkmanager" 
	      		"video" 
	      		"audio" 
	      		"wheel" 
	  	];
	  	shell = pkgs.zsh;
	};
	qt = {
		enable = true;
		platformTheme = "gtk2";
		style = "gtk2";
	};

	# Programs
	programs = {
		# Enable network manager applet
		nm-applet.enable = true;
		
		# Enable the shell system-wide.
		zsh.enable = true;
	};

	# Packages
	environment.systemPackages = with pkgs; [
		# Terminal
		zsh
		alacritty
		starship
		neovim
		eza
		rofi
		feh
		fzf
		fd
		ripgrep
        openvpn
		#youtube-dl
        stow

        #drivers
        xorg.xf86videoamdgpu

		# Fonts
		nerdfonts

		# Application
		firefox
		libreoffice
		pcmanfm
		prusa-slicer
		#freecad
		gimp
		discord
		steam
        gparted
        logseq
        arandr
        pavucontrol
        alsa-utils
        nextcloud-client
        syncthing
        calibre
        networkmanager-openvpn
        vlc
        zathura

		# Tools
		git
		zip
		unzip
		wget
		tree-sitter
        inetutils

		# Languages
		lua
        luajitPackages.luarocks
        cargo
		gcc
		python3Full
        python312Packages.tkinter
		nodejs_22

	];

	system.stateVersion = "24.11";

}

