# This file defines overlays
{inputs, ...}: 
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  cachyos-kernel = inputs.nix-cachyos-kernel.overlays.default;

  # Use Lix
  nix_lix = final: prev: {
    inherit
      (prev.lixPackageSets.latest)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena
      ;
  };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    utillinux = final.util-linux;


    # Fix proton-vpn dependencies until https://github.com/NixOS/nixpkgs/pull/509227 gets merged
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (_: python-prev: {
        proton-vpn-api-core = python-prev.proton-vpn-api-core.overridePythonAttrs (_: rec {
          version = "4.19.1";
          src = prev.fetchFromGitHub {
            owner = "ProtonVPN";
            repo = "python-proton-vpn-api-core";
            rev = "v${version}";
            hash = "sha256-PD/UQ+BoDO6firhlBJDRNrtiHgnp+4uIb8j+egXqxPA=";
          };
        });
      })
    ];
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config = {
        allowUnfree = final.config.allowUnfree or false;
      };
    };
  };

  # Same as above for master packages
  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.stdenv.hostPlatform.system;
      config = final.config;
    };
  };
}
