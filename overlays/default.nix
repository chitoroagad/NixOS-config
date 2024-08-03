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

    # Apply patch to prevent hanging on shutdown
    tmux = prev.tmux.overrideAttrs (old: {
      patches =
        (prev.patches or [])
        ++ [
          (prev.fetchpatch {
            url = "https://github.com/tmux/tmux/commit/3823fa2c577d440649a84af660e4d3b0c095d248.patch";
            hash = "sha256-FZDy/ZgVdwUAam8g5SfGBSnMhp2nlHHfrO9eJNIhVPo=";
          })
        ];
    });
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
