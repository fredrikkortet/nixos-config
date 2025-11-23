{
  # ================================================================ #
  # =                           WELCOME!                           = #
  # ================================================================ #

  description = "TipparnOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default-linux";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    #stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      systems,
      ...
    }@inputs:
    let

      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;
      #nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      #overlays = import ./overlays {inherit inputs outputs;};

      #packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #
        #Main desktop
        desktop = lib.nixosSystem {
          modules = [ ./hosts/desktop ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        #Main laptop
        laptop = lib.nixosSystem {
          modules = [ ./hosts/laptop ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        #Main framework
        framework = lib.nixosSystem {
          modules = [ ./hosts/framework ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

      };
      homeConfigurations = {
        # ===================== home-manager Configurations ===================== #
        #Main desktop
        "tipparn@desktop" = lib.homeManagerConfiguration {
          modules = [
            ./home/tipparn/desktop.nix
            ./home/tipparn/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

        #Main laptop
        "tipparn@laptop" = lib.homeManagerConfiguration {
          modules = [
            ./home/tipparn/laptop.nix
            ./home/tipparn/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
        #Main framework
        "tipparn@framework" = lib.homeManagerConfiguration {
          modules = [
            ./home/tipparn/framework.nix
            ./home/tipparn/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

      };
    };
}
