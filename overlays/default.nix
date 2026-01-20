# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  cachyos-kernel = inputs.nix-cachyos-kernel.overlays.pinned;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    utillinux = final.util-linux;
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config = {
        allowUnfree = final.config.allowUnfree or false;
      };
    };
  };

  # Same as above for master packages
  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config = final.config;
    };
  };

  # rocm-stable = final: _prev: {
  #   stable =
  #     import inputs.nixpkgs-stable
  #     {
  #       system = final.system;
  #     }.rocmPackages;
  # };
}
