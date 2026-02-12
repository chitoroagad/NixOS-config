{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixpkgs-master.url = "github:nixos/nixpkgs";

    # NixOS-Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Colorscheme
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # Ags
    ags.url = "github:Aylur/ags/v1";

    agsv2.url = "github:Aylur/ags";
    agsv2.inputs.nixpkgs.follows = "nixpkgs";

    # astal
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";

    # idle inhibitor
    vigiland.url = "github:jappie3/vigiland";

    # shell
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    astal,
    nixos-hardware,
    dankMaterialShell,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      LeMachine = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };

        modules = [
          ./nixos
          catppuccin.nixosModules.catppuccin
          nixos-hardware.nixosModules.framework-16-7040-amd
        ];
      };
    };

    homeConfigurations = {
      "darius@LeMachine" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          asztal = nixpkgs.legacyPackages.x86_64-linux.callPackage ./home/desktop/common/ags {inherit inputs;};
        };
        modules = [
          ./home
          catppuccin.homeModules.catppuccin
          dankMaterialShell.homeModules.dank-material-shell
        ];
      };
    };
  };
}
