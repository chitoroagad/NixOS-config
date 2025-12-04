# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

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
      config = final.config;
    };
  };

  # Same as above for master packages
  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config = final.config;
    };
  };

  xpadneo-fix = _final: prev: {
    linuxPackages_latest = prev.linuxPackages_latest.extend(_lfinal: lprev: {
      xpadneo = lprev.xpadneo.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (prev.fetchpatch {
              url = "https://github.com/orderedstereographic/xpadneo/commit/233e1768fff838b70b9e942c4a5eee60e57c54d4.patch";
              hash = "sha256-HL+SdL9kv3gBOdtsSyh49fwYgMCTyNkrFrT+Ig0ns7E=";
              stripLen = 2;
            })
          ];
      });
    });
  };

  # rocm-stable = final: _prev: {
  #   stable =
  #     import inputs.nixpkgs-stable
  #     {
  #       system = final.system;
  #     }.rocmPackages;
  # };
}
