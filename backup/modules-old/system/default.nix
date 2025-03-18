
{ config, pkgs, inputs, ...}:

{
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
    system.stateVersion = "24.11";
}
