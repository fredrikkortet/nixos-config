{
  # ================================================================ #
  # =                           WELCOME!                           = #
  # ================================================================ #

  description = "TipparnOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";

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
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
          devShells = import ./shell.nix { inherit pkgs; };

          #packages = import ./pkgs { inherit pkgs; };
        };

      flake =
        let
          inherit (nixpkgs) lib;
          outputs = {
            #nixosModules = import ./modules/nixos;
            homeManagerModules = import ./modules/home-manager;
            #overlays = import ./overlays { inherit inputs outputs; };
          };
          specialArgs = { inherit inputs outputs; };
        in
        {
          inherit (outputs) homeManagerModules;
          #inherit (outputs) nixosModules overlays;

          nixosConfigurations = {
            # ===================== NixOS Configurations ===================== #
            # Main desktop
            desktop = lib.nixosSystem {
              modules = [ ./hosts/desktop ];
              specialArgs = specialArgs;
            };
            # Main laptop
            laptop = lib.nixosSystem {
              modules = [ ./hosts/laptop ];
              specialArgs = specialArgs;
            };
            # Main framework
            framework = lib.nixosSystem {
              modules = [ ./hosts/framework ];
              specialArgs = specialArgs;
            };
          };
        };
    };
}
