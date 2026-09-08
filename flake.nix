{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixpkgs-master.url = "github:nixos/nixpkgs";

    # NixOS-Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Colorscheme
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # shell
    # Pinned: stable at aa4b99d ships a vendorHash that does not match its
    # go.sum, so dms-shell fails to build. Back to /stable once upstream fixes it.
    dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell/0bbe83380c9406d262d567581d64477d261c9ee5";
    dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
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

    # Which users live on which host. The single source of truth for both
    # nixosConfigurations and homeConfigurations, since home-manager is applied
    # standalone rather than as a NixOS module.
    hosts = {
      LeMachine = {
        system = "x86_64-linux";
        users = ["darius"];
      };
    };
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

    # Available through 'nixos-rebuild --flake .#<hostname>'
    nixosConfigurations =
      nixpkgs.lib.mapAttrs (
        hostname: host:
          nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs outputs;};
            modules =
              [
                ./nixos
                ./hosts/${hostname}
                catppuccin.nixosModules.catppuccin
                nixos-hardware.nixosModules.framework-16-7040-amd
              ]
              ++ builtins.concatMap (user: [
                (import ./users/${user}/common.nix).system
                (import ./users/${user}/${hostname}.nix).system
              ])
              host.users;
          }
      )
      hosts;

    # Available through 'home-manager switch --flake .#<user>@<hostname>'
    homeConfigurations = builtins.listToAttrs (
      nixpkgs.lib.flatten (
        nixpkgs.lib.mapAttrsToList (
          hostname: host:
            map (user: {
              name = "${user}@${hostname}";
              value = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${host.system};
                extraSpecialArgs = {inherit inputs outputs;};
                modules = [
                  ./home
                  (import ./users/${user}/common.nix).home
                  (import ./users/${user}/${hostname}.nix).home
                  catppuccin.homeModules.catppuccin
                  dankMaterialShell.homeModules.dank-material-shell
                ];
              };
            })
            host.users
        )
        hosts
      )
    );
  };
}
