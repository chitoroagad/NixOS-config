{
  config,
  lib,
  inputs,
  ...
}: {
  options.mine.system.nix.enable = lib.mkEnableOption "nix";

  config = lib.mkIf config.mine.system.nix.enable {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = ["nix-command" "flakes"];
        # Make nix path match flake inputs
        nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };
      # Disable channels
      channel.enable = false;

      # Make flake registry match flake inputs
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    };
  };
}
