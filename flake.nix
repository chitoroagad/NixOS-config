{
  description = "My NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # remember to revert this
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # NixOS-Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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
    swww.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland git
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprlock git
    hyprlock.url = "git+https://github.com/hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";

    # Hypridel git
    hypridle.url = "git+https://github.com/hyprwm/hypridle";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";

    # Ags
    ags.url = "github:Aylur/ags/67b0e31ded361934d78bddcfc01f8c3fcf781aad";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    agsv2.url = "github:Aylur/ags";
    agsv2.inputs.nixpkgs.follows = "nixpkgs";

    # astal
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";

    matugen.url = "github:InioX/matugen?ref=v2.2.0";

    # idle inhibitor
    vigiland.url = "github:jappie3/vigiland";

    # Ghostty
    ghostty = {
      url = "github:ghostty-org/ghostty";
      # inputs.nixpkgs-stable.follows = "nixpkgs-stable";
      # inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    # NVF
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    # nix-alien
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    astal,
    nvf,
    nixos-hardware,
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
          catppuccin.homeManagerModules.catppuccin
          nvf.homeManagerModules.default
        ];
      };
    };
  };
}
