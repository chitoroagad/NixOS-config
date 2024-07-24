{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland tools
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprland-contrib.inputs.nixpkgs.follows = "nixpkgs";

    # Colorscheme
    catppuccin.url = "github:catppuccin/nix";

    # Wallpaper
    swww.url = "github:LGFae/swww";

    # Hyprland git
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Hyprlock git
    hyprlock.url = "git+https://github.com/hyprwm/hyprlock";

    # Hypridel git
    hypridle.url = "git+https://github.com/hyprwm/hypridle";

    # Ags
    ags.url = "github:Aylur/ags";

    # Flox
    # flox.url = "github:flox/flox";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
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

    pkgs-stable = forAllSystems (system: inputs.nixpkgs-stable.legacyPackages.${system});
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
        specialArgs = {inherit inputs outputs pkgs-stable;};

        modules = [
          ./nixos
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin

          {
            home-manager.users.darius = {
              imports = [
                ./home
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = {inherit inputs outputs pkgs-stable;};
          }
        ];
      };
    };
  };
}
